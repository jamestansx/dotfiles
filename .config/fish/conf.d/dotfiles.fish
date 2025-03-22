function __dotfiles_git_handler --on-variable PWD
    if test "$PWD" = "$HOME"
        set -gx GIT_DIR $HOME/.dotfiles
        set -gx GIT_WORK_TREE $HOME
    else
        set -u GIT_DIR
        set -u GIT_WORK_TREE
    end
end

__dotfiles_git_handler
