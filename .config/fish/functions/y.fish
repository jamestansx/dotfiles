# A wrapper to cd when exiting yazi
# NOTE: use `Q` to quit without cd
function y
    set -f tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"

    if set cwd (command cat -- "$tmp");
        and [ -n "$cwd" ];
        and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end

    rm -f -- "$tmp"
end
