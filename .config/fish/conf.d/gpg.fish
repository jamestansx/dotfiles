status is-login || exit

# Replace SSH with gpg-agent. Ensure it is started
# See https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
gpgconf --launch gpg-agent

# See https://wiki.archlinux.org/title/GnuPG#SSH_agent
set -e SSH_AGENT_PID
set -q gnupg_SSH_AUTH_SOCK_by || set -l gnupg_SSH_AUTH_SOCK_by 0
if test "$gnupg_SSH_AUTH_SOCK_by" -ne "$fish_pid"
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
