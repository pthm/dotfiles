function dotfiles --description 'Manage dotfiles (bare repo in ~/.dotfiles, work-tree = $HOME)'
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
