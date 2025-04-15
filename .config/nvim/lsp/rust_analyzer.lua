return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
    capabilities = {
        experimental = {
            serverStatusNotification = true,
        },
    },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
            },
            checkOnSave = true,
        },
    },
    before_init = function(init_params, config)
        if config.settings and config.settings["rust-analyzer"] then
            init_params.initializationOptions = config.settings["rust-analyzer"]
        end
    end,
}
