local M = {}
local state = {
    diagcount = {},
    lsp_attached = false,
}

-- TODO:
-- - check truncate condition on 'VimResized' event or within function itself
-- - add customizable highlight color to components
-- - add "busy" indicator
local config = {
    lsp_icon = "●",
    diagnostic = {
        [vim.diagnostic.severity.ERROR] = { sign = "E", hl = "DiagnosticSignError" },
        [vim.diagnostic.severity.WARN] = { sign = "W", hl = "DiagnosticSignWarn" },
        [vim.diagnostic.severity.INFO] = { sign = "I", hl = "DiagnosticSignInfo" },
        [vim.diagnostic.severity.HINT] = { sign = "H", hl = "DiagnosticSignHint" },
    },
}

local filename = function() return "%f%( %h%w%m%r%)" end
local ruler = function() return "%-6.(%l,%v%) (%P)" end
local diagcount = function(buf) return state.diagcount[buf] or "" end

local gitinfo = function(buf)
    local summary = vim.b[buf].minigit_summary_string or ""
    if summary == "" then return "" end
    return (" %s"):format(summary) --   
end

local fileinfo = function()
    local filetype = vim.bo.filetype
    local fileformat = vim.bo.fileformat
    local fileencoding = vim.bo.fileencoding
    local icon = state.lsp_attached and config.lsp_icon or ""
    return ("%%(%s %%)%%(%s %%)%s[%s]"):format(icon, filetype, fileencoding, fileformat)
end

local diag_cb = function(args)
    local buf = args.buf
    local count = vim.diagnostic.count(buf)

    if #count == 0 then
        state.diagcount[buf] = nil
    else
        local t = {}
        for i, v in pairs(count) do
            if v > 0 then
                local s = config.diagnostic[i]
                t[#t + 1] = ("%%#%s#%s:%s%%*"):format(s.hl, s.sign, v)
            end
        end
        state.diagcount[buf] = #t > 0 and table.concat(t, " ") or nil
    end

    if vim.api.nvim_get_current_buf() == buf then
        vim.api.nvim__redraw({ buf = buf, statusline = true })
    end
end

local lsp_cb = function()
    state.lsp_attached = vim.tbl_count(vim.lsp.get_clients()) > 0
    vim.api.nvim__redraw({ statusline = true })
end

local join_component = function(comp) return comp == "" and "" or (" %s "):format(comp) end
M.statusline = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local comp = {
        filename(), gitinfo(bufnr), diagcount(bufnr),
        -- TODO: lsp progress dynamically set compact mode
        "%{v:lua.require'me.lsp.status'.get_progress(1)}", "%<%=",
        fileinfo(), ruler(),
    }

    return table.concat(vim.tbl_map(join_component, comp))
end

M.setup = function()
    local augroup = vim.api.nvim_create_augroup("me.statusline", { clear = true })
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        group = augroup,
        callback = vim.schedule_wrap(diag_cb),
    })
    vim.api.nvim_create_autocmd({"LspAttach", "LspDetach"}, {
        group = augroup,
        callback = vim.schedule_wrap(lsp_cb),
    })

    return "%{%v:lua.require'me.statusline'.statusline()%}"
end

return M
