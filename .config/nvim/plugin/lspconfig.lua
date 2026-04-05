local augroup = require("me").augroup
local autocmd = vim.api.nvim_create_autocmd

vim.lsp.config("*", {
    root_markers = {
        ".git",
    },
})

vim.lsp.enable({
    "rust_analyzer",
    "tsserver",
    "dartls",
    "tinymist",
})

autocmd("LspAttach", {
    group = augroup,
    once = true,
    callback = function()
        vim.print("Set options")
        -- vim.lsp.log.set_format_func(vim.inspect)
        vim.lsp.log.set_level(vim.lsp.log.levels.ERROR)
    end,
})

autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "grq", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<bs>", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)
    end,
})

autocmd("LspProgress", {
    group = augroup,
    callback = function(ev)
        local val = ev.data.params.value
        vim.api.nvim_echo({{val.message or "done"}}, false, {
            source = "vim.lsp",
            id = "LspProgress",
            kind = "progress",
            percent = val.percentage,
            status = val.kind ~= "end" and "running" or "success",
            title = val.title,
        })
    end,
})
