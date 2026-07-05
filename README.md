# dotfiles

My Mac setup, managed as a **bare git repo** whose work-tree is `$HOME`
(the [codevoid / Atlassian method](https://home.codevoid.de/posts/2019-04-27_Manage_dotfiles_with_git.html)).
Config files live at their real paths in `$HOME` — no symlinks. A `dotfiles`
command (a thin git wrapper) is used to track them.

## Set up a new Mac

```sh
# 1. command-line tools (git, curl, …)
xcode-select --install

# 2. clone the bare repo straight into $HOME
git clone --bare https://github.com/pthm/dotfiles.git "$HOME/.dotfiles"
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no

# 3. sign in to the App Store (needed for the mas apps), then bootstrap
~/bootstrap.sh
```

If step 2's `checkout` complains a file would be overwritten, move the existing
one aside (e.g. `mv ~/.gitconfig ~/.gitconfig.bak`) and re-run the checkout.

### What `bootstrap.sh` does

Idempotent — safe to re-run.

1. Installs Homebrew (if missing)
2. `brew bundle` — system tools, GUI apps, fonts, App Store apps from `Brewfile`
3. `mise install` — languages + dev CLIs from `.config/mise/config.toml`
4. Installs fish plugins (fisher + tide + rosé-pine)
5. Generates an SSH key (`~/.ssh/id_ed25519`), stores the passphrase in the
   macOS Keychain, writes `~/.ssh/allowed_signers`
6. Sets fish as the default login shell
7. `gh auth login`, then uploads the key to GitHub as both an **authentication**
   and a **signing** key
8. Points this repo's remote at SSH and verifies auth

It prompts for: your Mac password (shell change), an SSH key passphrase, and a
browser sign-in for GitHub. Open a new terminal afterwards to land in fish.

## Day-to-day

Track and update dotfiles with the `dotfiles` command (auto-loaded as a fish
function; in bash/zsh add `alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'`):

```sh
dotfiles status
dotfiles add ~/.config/ghostty/config   # always add explicit paths, never `add .`
dotfiles commit -m "tweak ghostty"
dotfiles push
```

Commits are signed with your SSH key automatically.

## Package management split

- **Homebrew** (`Brewfile`) — system utilities, shells, VCS, signing tools,
  media tools, and GUI apps/casks.
- **mise** (`.config/mise/config.toml`) — language runtimes and developer CLIs
  (go/node/bun tooling, helm, kubectx, cloud-sql-proxy, gcloud, just, task, …).
  Prefer mise for anything toolchain-shaped; brew for system-level bits.

## What's tracked

`Brewfile`, `bootstrap.sh`, `.gitconfig`, `.gitignore`, `.ssh/config`, and
configs under `.config/` (fish, ghostty, zed, jj, mise) and `.claude/`.

**Not** tracked (see `.gitignore`): SSH private keys, `allowed_signers`, and
Claude runtime/history — the SSH key is generated per-machine by `bootstrap.sh`.

Identity: `Patt-Tom McDonnell <contact@mcdonnell.pt>`, SSH commit signing with
`~/.ssh/id_ed25519.pub`.
