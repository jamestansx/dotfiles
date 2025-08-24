local M = {}
local _internal = {
    timer = nil,
    spinner_idx = 0,
    augroup = vim.api.nvim_create_augroup("me.lsp.status", { clear = true }),
}
local config = {
    max_message_width = 17,
    update_ms = 100,
    icons = {
        spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        done = "✔",
    }
}

local status = {
    name = "",
    title = "",
    message = nil,
    percentage = "",
    running = false,
}

local spin = function()
    if _internal.timer:is_active() then return end

    local t = config.update_ms
    _internal.timer:start(t, t, vim.schedule_wrap(function()
        if not status.running then
            vim.defer_fn(function()
                -- New progress update, don't clear the status
                if status.running then return end

                status.message = nil
                vim.api.nvim__redraw({ statusline = true })
            end, 1000)
            _internal.timer:stop()
        end

        local idx = _internal.spinner_idx
        _internal.spinner_idx = idx == #config.icons.spinners and 1 or idx + 1
        vim.api.nvim__redraw({ statusline = true })
    end))
end

-- full:    [name] ⣾ title (xxx%) - message
-- compact: [name] ⣾ title
M.get_progress = function(compact)
    if status.message == nil then return "" end
    local icon = status.running and config.icons.spinners[_internal.spinner_idx] or config.icons.done

    local buffer = { status.name, icon }
    if status.title ~= "" then buffer[#buffer + 1] = status.title end

    if compact == 0 then
        if status.percentage ~= "" then buffer[#buffer + 1] = status.percentage end
        if status.message ~= "" then
            buffer[#buffer + 1] = "-"
            buffer[#buffer + 1] = status.message
        end
    end

    return table.concat(buffer, " ")
end

local truncate = function(str, len, placeholder)
    if #str <= len then return str end
    return ("%s%s"):format(str:sub(1, len), placeholder)
end

M.setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = _internal.augroup,
        callback = function()
            if _internal.timer then return end
            _internal.timer = assert(vim.uv.new_timer())
        end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
        group = _internal.augroup,
        callback = function()
            -- Detaching client is inclusive too
            if #vim.lsp.get_clients() > 1 then return end

            if _internal.timer and not _internal.timer:is_closing() then
                -- Cleanup
                status.name = ""
                status.message = nil
                status.running = false
                _internal.spinner_idx = 0

                _internal.timer:stop()
                _internal.timer:close()
                _internal.timer = nil
                vim.api.nvim__redraw({ statusline = true })
            end
        end,
    })

    vim.api.nvim_create_autocmd("LspProgress", {
        group = _internal.augroup,
        callback = function(args)
            local id = args.data.client_id
            local value = args.data.params.value
            local name = vim.lsp.get_client_by_id(id).name

            status.name = ("[%s]"):format(name)
            status.title = value.title or ""
            status.percentage = value.percentage and ("(%3d%%)"):format(value.percentage) or ""
            status.message = truncate(value.message or "", config.max_message_width, "…")

            status.running = value.kind ~= "end"
            if status.running then spin() end
        end,
    })
end

return M
