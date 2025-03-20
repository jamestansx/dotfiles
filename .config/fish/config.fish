if status is-login
    # XDG base directories
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    fish_add_path -gP $HOME/.local/bin

    # Defaults
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx TERMINAL foot
    set -gx BROWSER firefox-developer-edition

    # NOTE: machine specific variables!
    # See https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuration
    set -gx VDPAU_DRIVER va_gl
    set -gx ANV_VIDEO_DECODE 1

    # NOTE: fish shell does not source /etc/profile
    # Ported important ones from them and source them manually
    fish_add_path -gP /usr/local/sbin /usr/local/bin /usr/bin
    fish_add_path -gP /usr/lib/rustup/bin

    set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
    set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
    set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
    set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME"/nv
end

if status is-login
    # Replace SSH with gpg-agent. Ensure it is started
    # See https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
    gpgconf --launch gpg-agent

    # See https://wiki.archlinux.org/title/GnuPG#SSH_agent
    set -e SSH_AGENT_PID
    set -q gnupg_SSH_AUTH_SOCK_by || set -l gnupg_SSH_AUTH_SOCK_by 0
    if test $gnupg_SSH_AUTH_SOCK_by -ne $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end

    if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        set -gx XDG_SESSION_TYPE wayland
        set -gx XDG_CURRENT_DESKTOP river
        set -gx _JAVA_AWT_WM_NONREPARENTING 1

        set -gx MOZ_ENABLE_WAYLAND 1
        set -gx QT_QPA_PLATFORM wayland

        # Checkout https://github.com/swaywm/sway/wiki#i-cant-open-links-in-external-applications-in-firefox
        set -gx MOZ_DBUS_REMOTE 1

        set -l timestamp (date +%F-%R)
        exec river -log-level warning > /tmp/river-$timestamp.log 2>&1
    end
end

if status is-interactive
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye &>/dev/null
end
