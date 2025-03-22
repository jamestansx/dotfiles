status is-login || exit

set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state
fish_add_path -gP "$HOME"/.local/bin

# Defaults
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TERMINAL foot
set -gx BROWSER firefox-developer-edition

# NOTE: machine specific variables!
# See https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuration
set -gx VDPAU_DRIVER va_gl
set -gx ANV_VIDEO_DECODE 1

# XDG base directories
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME"/nv
set -gx PARALLEL_HOME "$XDG_CONFIG_HOME"/parallel
set -gx PYTHON_HISTORY "$XDG_STATE_HOME"/python_history
set -gx PYTHONUSERBASE "$XDG_DATA_HOME"/python

# NOTE: fish shell does not source /etc/profile
# Ported important ones from them and source them manually
fish_add_path -gP /usr/local/sbin /usr/local/bin /usr/bin
fish_add_path -gP /usr/lib/rustup/bin
