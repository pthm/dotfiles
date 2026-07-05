# dotfiles

Personal Mac setup managed as a **bare git repo** whose work-tree is `$HOME`
(the [codevoid/Atlassian method](https://home.codevoid.de/posts/2019-04-27_Manage_dotfiles_with_git.html)).
Files live at their real paths in `$HOME` — no symlinks. Interact via `dotfiles`:

```sh
dotfiles status
dotfiles add ~/.config/ghostty/config   # always add explicit paths, never `add .`
dotfiles commit -m "tweak ghostty"
dotfiles push
```

In fish the `dotfiles` function auto-loads from
`~/.config/fish/functions/dotfiles.fish`. In bash/zsh add:

```sh
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

## What's tracked

- `Brewfile` — system tools + GUI apps + fonts + App Store apps
- `bootstrap.sh` — installs Homebrew + Brewfile, mise toolchains, fish plugins,
  generates the SSH key, sets fish as default shell, logs in to GitHub, uploads
  the auth + signing keys
- `.gitconfig`, `.config/jj/config.toml` — identity + SSH commit signing
  (`Patt-Tom McDonnell <contact@mcdonnell.pt>`, key `~/.ssh/id_ed25519.pub`)
- `.config/mise/config.toml` — global dev toolchains
- `.config/fish/`, `.config/ghostty/`, `.config/zed/`, `.claude/` — app configs
- `.gitignore` — safety net so secrets/runtime data can't be committed

The SSH private key, `allowed_signers`, and Claude runtime/history are **not**
tracked (see `.gitignore`) — the key is generated per-machine by `bootstrap.sh`.

## Set up a brand-new Mac

```sh
# 1. command-line tools (git, etc.)
xcode-select --install

# 2. clone the bare repo straight into $HOME
git clone --bare https://github.com/pthm/dotfiles.git "$HOME/.dotfiles"
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no

# 3. sign into the App Store (for the mas apps), then bootstrap
~/bootstrap.sh
```

If step 2's `checkout` reports a file would be overwritten, move the existing
one aside (`mv ~/.gitconfig ~/.gitconfig.bak`) and re-run the checkout.

Repo is public so step 2 works before any auth exists — keep it secret-free.
