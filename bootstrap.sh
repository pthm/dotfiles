#!/usr/bin/env bash
# Bootstrap a Mac from the dotfiles bare repo. Idempotent — safe to re-run.
#
# Get the dotfiles onto a fresh machine first (bare-repo method):
#   xcode-select --install
#   git clone --bare https://github.com/pthm/dotfiles.git "$HOME/.dotfiles"
#   git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
#   git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
# Then run:  ~/bootstrap.sh
set -euo pipefail

GIT_EMAIL="contact@mcdonnell.pt"
SSH_KEY="$HOME/.ssh/id_ed25519"
SSH_PUB="$SSH_KEY.pub"
step() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }

# 0. Ensure the bare dotfiles repo ignores untracked $HOME files, so
#    `dotfiles status` stays clean even if it was cloned without that flag.
#    The `dotfiles` command itself is a fish function tracked at
#    ~/.config/fish/functions/dotfiles.fish (auto-loaded by fish). For bash/zsh:
#      alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
if [ -d "$HOME/.dotfiles" ]; then
  step "dotfiles repo config"
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no || true
fi

# 1. Xcode command-line tools
xcode-select -p >/dev/null 2>&1 || xcode-select --install || true

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  step "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Packages & apps (sign into the App Store first for the mas entries)
step "brew bundle"
brew bundle --file="$HOME/Brewfile" \
  || echo "   WARN: some Brewfile entries failed (mas apps need App Store sign-in) — continuing"

# 4. Dev toolchains
step "mise toolchains"
mise trust "$HOME/.config/mise/config.toml" 2>/dev/null || true
mise install --yes || echo "   WARN: some mise tools failed to install — continuing"

# 5. Fish plugins (fisher + tide + rose-pine, from ~/.config/fish/fish_plugins)
step "fish plugins"
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update' \
  || echo "   WARN: fisher/plugin step failed — continuing"

# 6. SSH key → Keychain, and allowed_signers for local verification
step "SSH key"
mkdir -p "$HOME/.ssh"; chmod 700 "$HOME/.ssh"
[ -f "$SSH_KEY" ] || ssh-keygen -t ed25519 -a 100 -C "$GIT_EMAIL" -f "$SSH_KEY"
# Apple's ssh-add explicitly — --apple-use-keychain is macOS-only and Homebrew's
# openssh (if present) doesn't support it.
/usr/bin/ssh-add --apple-use-keychain "$SSH_KEY"
printf '%s namespaces="git" %s\n' "$GIT_EMAIL" "$(cat "$SSH_PUB")" > "$HOME/.ssh/allowed_signers"
chmod 600 "$HOME/.ssh/allowed_signers"

# 7. fish as the default login shell
step "default shell → fish"
FISH="$(command -v fish)"
grep -qx "$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells >/dev/null
[ "$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')" = "$FISH" ] \
  || chsh -s "$FISH" || echo "   WARN: could not set fish as default shell — continuing"

# 8. GitHub auth + upload auth & signing keys
step "GitHub auth"
if ! gh auth status >/dev/null 2>&1; then
  gh auth login --hostname github.com --git-protocol ssh
fi
gh auth status 2>&1 | grep -q admin:ssh_signing_key || \
  gh auth refresh -h github.com -s admin:public_key,admin:ssh_signing_key
TITLE="$(scutil --get ComputerName 2>/dev/null || hostname -s)"
gh ssh-key add "$SSH_PUB" --type authentication --title "$TITLE"           2>/dev/null || echo "   auth key already present"
gh ssh-key add "$SSH_PUB" --type signing        --title "$TITLE (signing)" 2>/dev/null || echo "   signing key already present"

# 9. Switch the dotfiles remote to SSH now that keys exist
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" \
  remote set-url origin git@github.com:pthm/dotfiles.git 2>/dev/null || true

# 10. Verify
step "verify GitHub SSH auth"
/usr/bin/ssh -o StrictHostKeyChecking=accept-new -T git@github.com || true

echo
echo "Done. Open a new terminal to land in fish."
