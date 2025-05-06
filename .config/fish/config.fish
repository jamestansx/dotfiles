if status is-login; and test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
    set -gx XDG_SESSION_TYPE wayland
    set -gx XDG_CURRENT_DESKTOP river
    set -gx _JAVA_AWT_WM_NONREPARENTING 1

    # Checkout https://github.com/swaywm/sway/wiki#i-cant-open-links-in-external-applications-in-firefox
    set -gx MOZ_DBUS_REMOTE 1
    set -gx MOZ_ENABLE_WAYLAND 1

    set -l timestamp (date +%F-%R)
    exec river -log-level warning > /tmp/river-$timestamp.log 2>&1
end

if status is-interactive
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye &>/dev/null
end
