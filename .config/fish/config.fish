# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# GNU coreutils without the 'g' prefix
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

fish_add_path ~/.local/bin
fish_add_path ~/go/bin

# mise — full activation for interactive shells, shims for everything else
# (editors, scripts, CI) so mise-managed tools resolve on PATH either way
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

# Theming (rose-pine/fish plugin, installed via fisher)
fish_config theme choose "Rosé Pine"

# OrbStack
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
