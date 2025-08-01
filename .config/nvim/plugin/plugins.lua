local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    require("vim._extui").enable({})
    vim.cmd("packadd! cfilter")
    vim.cmd("packadd! termdebug")
end)

now(function()
    vim.go.statusline = require("me.statusline").setup()
end)

now(function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    add("justinmk/vim-dirvish")

    -- sort directories with dotfiles first
    vim.g.dirvish_mode = [[:sort i | sort ,^.*[\/],]]

    -- required 'expr' to be true
    local eat_space = function(key)
        return function()
            local char = vim.fn.getchar(0)
            char = vim.fn.nr2char(char)
            return ("%s%s"):format(key, char:match("%s") and "" or char)
        end
    end

    local augroup = vim.api.nvim_create_augroup("me.dirvish", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "dirvish",
        callback = function(args)
            local opts = { buffer = args.buf, expr = true }

            vim.keymap.set("ca", "e", eat_space("e %"), opts)
            vim.keymap.set("ca", "mkdir", eat_space("!mkdir -p %"), opts)
        end,
    })
end)

-- lspconfig
now(function()
    local augroup = vim.api.nvim_create_augroup("me.lsp", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        callback = function(args)
            local buf = args.buf

            vim.keymap.set("n", "grq", vim.diagnostic.setqflist, { buffer = buf })
            vim.keymap.set("n", "<bs>", function()
                local enabled = not vim.lsp.inlay_hint.is_enabled()
                vim.lsp.inlay_hint.enable(enabled)
            end, { buffer = buf })
        end,
    })

    require("me.lsp.status").setup()

    vim.lsp.config("*", {
        root_markers = { ".git" },
    })

    vim.lsp.enable({
        "rust_analyzer",
        "tsserver",
        "dartls",
    })

    later(function()
        vim.lsp.log.set_format_func(vim.inspect)
        vim.lsp.log.set_level(vim.lsp.log.levels.ERROR)
    end)
end)

-- auto-completion
later(function()
    add({ source = "Saghen/blink.cmp", checkout = "v1.6.0" })

    require("blink.cmp").setup({
        keymap = {
            preset = "none",
            ["<c-n>"] = { "show", "select_next" },
            ["<c-p>"] = { "show", "select_prev" },
            ["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<c-e>"] = { "hide", "fallback" },
            ["<c-y>"] = { "select_and_accept", "fallback" },
            ["<cr>"] = { "accept", "fallback" },
            ["<tab>"] = { "snippet_forward", "fallback" },
            ["<s-tab>"] = { "snippet_backward", "fallback" },
            ["<c-b>"] = { "scroll_documentation_up", "fallback" },
            ["<c-f>"] = { "scroll_documentation_down", "fallback" },
            ["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            menu = { max_height = 5 },
            ghost_text = { enabled = true },
        },
        signature = {
            enabled = true,
            window = { show_documentation = false },
        },
        cmdline = { enabled = false },
    })
end)

-- formatting
later(function()
    add("stevearc/conform.nvim")

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    require("conform").setup({
        log_level = vim.log.levels.ERROR,
        formatters_by_ft = {
            dart = { "dart_format", lsp_format = "fallback" },
            rust = { "rustfmt" },
            ["_"] = { "trim_whitespace" },
        },
    })
end)

later(function()
    add({
        source = "ggandor/leap.nvim",
        depends = { "tpope/vim-repeat" },
    })

    local leap = require("leap")
    local user = require("leap.user")

    user.set_repeat_keys("<tab>", "<s-tab>", { relative_directions = true })
    leap.opts.equivalence_classes = { " \t\r\n", "({[", ")}]", "'\"`" }
    leap.opts.special_keys = {
        next_target = "<tab>",
        prev_target = "<s-tab>",
        next_group = "<space>",
        prev_group = "<s-space>",
    }

    vim.keymap.set({"n", "x", "o"}, "s", function() leap.leap({}) end)
    vim.keymap.set({"n", "x", "o"}, "S", function() leap.leap({ backward = true }) end)
    vim.keymap.set({"n", "x", "o"}, "gs", function() require("leap.remote").action() end)
    vim.keymap.set({"n", "x", "o"}, "gS", function() leap.leap({ target_windows = user.get_enterable_windows() }) end)

    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
end)

later(function()
    add("echasnovski/mini.pick")
    require("mini.pick").setup({ options = { content_from_bottom = true } })

    vim.ui.select = MiniPick.ui_select

    -- TODO: pick files with `proximity-sort`
    vim.keymap.set("n", "<leader>f", "<cmd>Pick files<cr>")
    vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<cr>")
    vim.keymap.set("n", "yop", "<cmd>Pick resume<cr>")

    vim.api.nvim_create_user_command("Help", "Pick help", {})
end)

later(function()
    add("echasnovski/mini-git")
    require("mini.git").setup()

    add("mbbill/undotree")
    vim.g.undotree_HelpLine = 0
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SetFocusWhenToggle = 1

    vim.keymap.set("n", "you", vim.cmd.UndotreeToggle)
end)
