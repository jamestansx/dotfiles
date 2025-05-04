local M = {}
local state = {
    diagcount = {},
    lsp_attached = false,
}

-- TODO: check truncate condition on 'VimResized' event or within function itself
-- TODO: add customizable highlight color to components
local config = {
    lsp_icon = "●",
    diagnostic = {
        { name = "ERROR", sign = "E", hl = "DiagnosticSignError" },
        { name = "WARN", sign = "W", hl = "DiagnosticSignWarn" },
        { name = "INFO", sign = "I", hl = "DiagnosticSignInfo" },
        { name = "HINT", sign = "H", hl = "DiagnosticSignHint" },
    },
}

local filename = function() return "%f%( %h%w%m%r%)" end
local ruler = function() return "%-6.(%l,%v%) (%P)" end
local diagcount = function(buf) return state.diagcount[buf] or "" end

local gitinfo = function()
    local summary = vim.b.minigit_summary_string or ""
    if summary == "" then return "" end

    return (" %s"):format(summary)
end

local fileinfo = function()
    local filetype = vim.bo.filetype
    local fileencoding = vim.bo.fileencoding
    local fileformat = vim.bo.fileformat
    local icon = state.lsp_attached and config.lsp_icon or ""

    return ("%%(%s %%)%%(%s %%)%s[%s]"):format(icon, filetype, fileencoding, fileformat)
end

local diag_cb = function(args)
    local buf = args.buf
    local current_buf = vim.api.nvim_get_current_buf()
    local count = vim.diagnostic.count(buf)

    if #count == 0 then
        state.diagcount[buf] = nil
    else
        local t = {}
        for _, v in ipairs(config.diagnostic) do
            local c = count[vim.diagnostic.severity[v.name]]
            if c and c > 0 then
                t[#t + 1] = ("%%#%s#%s%s%%*"):format(v.hl, v.sign, c)
            end
        end
        state.diagcount[buf] = #t > 0 and table.concat(t, " ") or nil
    end

    if current_buf == buf then vim.cmd.redrawstatus() end
end

local component = function(str) return str == "" and "" or (" %s "):format(str) end
M.statusline = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local comp = {
        filename(), gitinfo(), diagcount(bufnr),
        "%=",
        "%{v:lua.require'me.lsp.status'.get_progress()}", fileinfo(), ruler(),
    }

    return table.concat(vim.tbl_map(component, comp, ""))
end

M.setup = function()
    local augroup = vim.api.nvim_create_augroup("me.statusline", { clear = true })
    vim.api.nvim_create_autocmd("DiagnosticChanged", { group = augroup, callback = diag_cb })
    vim.api.nvim_create_autocmd({"LspAttach", "LspDetach"}, {
        group = augroup,
        callback = vim.schedule_wrap(function()
            state.lsp_attached = vim.tbl_count(vim.lsp.get_clients()) > 0
        end),
    })

    return "%{%v:lua.require'me.statusline'.statusline()%}"
end

return M
