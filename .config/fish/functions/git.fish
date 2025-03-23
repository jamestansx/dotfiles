function git
    if test "$PWD" = "$HOME"
        set -lx GIT_DIR "$HOME"/.dotfiles
        set -lx GIT_WORK_TREE $HOME
        command git $argv
    else
        command git $argv
    end
end
