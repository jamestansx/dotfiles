function git
    if test "$PWD" = "$HOME"
        set -fx GIT_DIR "$HOME"/.dotfiles
        set -fx GIT_WORK_TREE $HOME
        command git $argv
    else
        command git $argv
    end
end
