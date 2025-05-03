local lsp = require("me.lsp")
local command = vim.api.nvim_create_user_command

command("LspRestart", function(kwargs)
    lsp.restart(kwargs.fargs, kwargs.bang)
end, { nargs = "*", complete = lsp.complete_client_names, bang = true })

command("LspStop", function(kwargs)
    lsp.stop(kwargs.fargs, kwargs.bang)
end, { nargs = "*", complete = lsp.complete_client_names, bang = true })

command("LspInfo", function()
    vim.cmd("botright checkhealth vim.lsp")
end, {})

do -- lsp log
    local cmds = {
        ["open"] = lsp.log_open,
        ["clear"] = lsp.log_clear,
    }
    command("LspLog", function(kwargs)
        if vim.tbl_get(cmds, kwargs.args) then
            cmds[kwargs.args]()
        else -- default action
            lsp.log_open()
        end
    end, { nargs = "?", complete = function() return vim.tbl_keys(cmds) end })
end
