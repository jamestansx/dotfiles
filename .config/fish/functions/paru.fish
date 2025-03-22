# HACK: temporarily wrap paru command
# to fix GIT_DIR is set in HOME dir.
function paru
    set -lu GIT_DIR
    set -lu GIT_WORK_TREE
    command paru $argv
end
