# Brewfile — system tools + GUI apps only.
# Dev toolchains (go, node, buf, etc.) live in ~/.config/mise/config.toml, not here.
# Cut items are preserved in the commented block at the bottom — uncomment to restore.

tap "pthm/tap"
tap "zzet/tap"

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
brew "openssh"

# ── Build & release ──
brew "just"
brew "go-task"
brew "goreleaser"
brew "pre-commit"

# ── Kubernetes / cloud ──
brew "helm"
brew "helmfile"
brew "kubectx"
brew "stern"
brew "k9s"
brew "k3d"
brew "cloud-sql-proxy"
brew "grpcurl"
brew "temporal"

# ── Data / media ──
brew "libpq", link: true # psql & friends without a local server; see postgresql@18 below if you want the server
brew "sqruff"
brew "ffmpeg"
brew "imagemagick"
brew "tesseract"
brew "yt-dlp"

# ── Misc ──
brew "hugo"
brew "ccusage"
brew "tokei"
brew "mas"

# ── Fonts ──
cask "font-jetbrains-mono-nerd-font"

# ── Casks (apps with recent usage) ──
cask "1password"
cask "1password-cli"
cask "appcleaner"
cask "claude-code"
cask "cleanshot"
cask "cmux"
cask "deckset"
cask "gcloud-cli"
cask "ghostty"
cask "goland"
cask "google-chrome"
cask "linear-linear"
cask "ngrok"
cask "notion-calendar"
cask "ollama-app"
cask "orbstack" # provides the docker CLI — Docker Desktop not needed
cask "raindropio"
cask "slack"
cask "spotify"
cask "tableplus"
cask "tailscale-app"
cask "visual-studio-code"
cask "zed"
cask "zoom"
cask "pthm/tap/melange"
cask "zzet/tap/gortex", trusted: true

# ── App Store ──
mas "Xcode", id: 497799835
mas "Keynote", id: 409183694
mas "Pages", id: 409201541
mas "Numbers", id: 409203825

# ════════════════════════════════════════════════════════════════════
# CUT — no usage evidence on the old machine (15 months of shell
# history + app last-opened dates). Uncomment anything you miss.
# ════════════════════════════════════════════════════════════════════
# --- formulae ---
# brew "postgresql@18"     # local PG server; libpq above covers psql
# brew "neovim"            # ~/.config/nvim was empty
# brew "nmap"
# brew "iperf3"
# brew "telnet"
# brew "graphviz"
# brew "csvkit"
# brew "git-filter-repo"
# brew "git-quick-stats"
# brew "gource"
# brew "cowsay"
# brew "kubeseal"
# brew "kustomize"
# brew "cmctl"
# brew "hasura-cli"
# brew "mole"
# brew "z"                 # bash/zsh only — never wired into fish
# --- Swift/Xcode tooling (you use swiftly for toolchains) ---
# brew "swiftlint"
# brew "xcodegen"
# brew "xcbeautify"
# brew "create-dmg"
# --- casks ---
# cask "docker-desktop"    # OrbStack replaced it
# cask "firefox@developer-edition"
# cask "claude"            # desktop app; you use the CLI
# cask "obsidian"
# cask "notion"            # calendar kept; app unused (web?)
# cask "postman"
# cask "vlc"
# cask "keka"
# cask "the-unarchiver"
# cask "lens"              # k9s kept instead
# cask "gpg-suite"         # pinentry-mac covers commit signing
# cask "sketch"
# cask "soulver"
# cask "transmit"
# cask "calibre"
# cask "godot"
# cask "dataspell"
# cask "antigravity"
# cask "airfoil"
# cask "audio-hijack"
# cask "grandperspective"
# cask "hex-fiend"
# cask "yubico-yubikey-manager"
# cask "kegworks-app/kegworks/kegworks"
# --- App Store ---
# mas "Logic Pro", id: 634148309
# mas "GarageBand", id: 682658836
# mas "Photomator", id: 1444636541
# mas "Apple Configurator", id: 1037126344
