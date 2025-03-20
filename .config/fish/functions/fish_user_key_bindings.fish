function fish_user_key_bindings
    # Enable emacs mode in insert mode
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase

    # 'fg' on ctrl-z
    # See https://github.com/fish-shell/fish-shell/issues/7152#issuecomment-663575001
    bind ctrl-z 'fg 2>/dev/null; commandline -f repaint'

    # Accept autosuggestion and execute the command
    bind -M insert ctrl-y accept-autosuggestion execute
end
