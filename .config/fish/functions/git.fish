function git
    if test "$PWD" = "$HOME"
        set -fx GIT_DIR "$HOME"/.dotfiles
        set -fx GIT_WORK_TREE $HOME
    end
    command git $argv
end
