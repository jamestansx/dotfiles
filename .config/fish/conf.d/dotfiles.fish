# TODO: Remove this handler as it would break paru
# cloning git AUR. Instead, create a git alias that
# set local variable if in HOME directory.
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
