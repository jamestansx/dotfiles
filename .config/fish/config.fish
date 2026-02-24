if status is-login; and test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
    exec niri-session -l
end

if status is-interactive
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye &>/dev/null
end
