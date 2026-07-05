# Brewfile — system tools + GUI apps only.
# Dev toolchains (go, node, buf, etc.) live in ~/.config/mise/config.toml, not here.
# Cut items are preserved in the commented block at the bottom — uncomment to restore.

tap "pthm/tap"

# ── Shell & core ──
brew "fish"
brew "coreutils"
brew "curl"
brew "tmux"
brew "tree"
brew "watch"
brew "jq"
brew "yq"
brew "moor" # jj pager (referenced in jj/config.toml)
brew "mise"

# ── VCS ──
brew "git"
brew "jj"
brew "jjui"
brew "gh" # referenced by path in gitconfig credential helper — keep in brew, not mise
brew "git-lfs"

# ── Security / signing ──
brew "gnupg"
brew "pinentry-mac"
# NOTE: no brew "openssh" — it shadows Apple's ssh/ssh-add on PATH and breaks
# macOS Keychain integration (--apple-use-keychain / UseKeychain are Apple-only).

# ── Data / media ──
brew "libpq", link: true # psql & friends without a local server; see postgresql@18 below if you want the server
brew "ffmpeg"
brew "imagemagick"
brew "yt-dlp"

# ── Misc ──
brew "mas"
brew "mole"

# ── Fonts ──
cask "font-jetbrains-mono-nerd-font"

# ── Casks (apps with recent usage) ──
cask "1password"
cask "1password-cli"
cask "appcleaner"
cask "claude-code"
cask "cleanshot"
cask "ghostty"
cask "goland"
cask "google-chrome"
cask "orbstack" # provides the docker CLI — Docker Desktop not needed
cask "slack"
cask "spotify"
cask "tableplus"
cask "tailscale-app"
cask "visual-studio-code"
cask "zed"

# ── App Store ──
mas "Xcode", id: 497799835
