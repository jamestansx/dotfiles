local M = {}

local status = {
    name = "",
    message = "",
    running = false,
    spinner_idx = 0,
    timer = nil,
}

local augroup = vim.api.nvim_create_augroup("me.lsp.status", { clear = true })
local config = {
    max_message_width = 17,
    update_ms = 100,
    icons = {
        spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        done = "✔",
    }
}

-- format: (xxx%) title - message
local format_progress = function(value)
    local builder = {}
    local title = value.title or ""
    local percent = value.percentage and ("(%3d%%)"):format(value.percentage)
    local message = value.message or ""
    -- truncate long message
    if #message > config.max_message_width then
        message = message:sub(1, config.max_message_width) .. "…"
    end

    if title ~= "" then builder[#builder + 1] = title end
    if percent then builder[#builder + 1] = percent end
    if message ~= "" then
        builder[#builder + 1] = "-"
        builder[#builder + 1] = message
    end

    return table.concat(builder, " ")
end

local spin = function()
    if status.timer:is_active() then return end

    local t = config.update_ms
    status.timer:start(t, t, vim.schedule_wrap(function()
        if not status.running then
            vim.defer_fn(function()
                -- New progress update, don't clear the status
                if status.running then return end

                status.message = ""
                vim.cmd.redrawstatus()
            end, 1000)
            status.timer:stop()
        end

        local idx = status.spinner_idx
        status.spinner_idx = idx == #config.icons.spinners and 1 or idx + 1
        vim.cmd.redrawstatus()
    end))
end

M.get_progress = function()
    if status.message == "" then return "" end

    local icon = status.running and config.icons.spinners[status.spinner_idx] or config.icons.done
    return ("%s %s %s"):format(status.name, icon, status.message)
end

M.setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        callback = function()
            if status.timer then return end
            status.timer = assert(vim.uv.new_timer())
        end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
        group = augroup,
        callback = function()
            if #vim.lsp.get_clients() > 0 then return end
            if status.timer and not status.timer:is_closing() then
                vim.cmd.redrawstatus()
                status.timer:stop()
                status.timer:close()
            end
        end,
    })

    vim.api.nvim_create_autocmd("LspProgress", {
        group = augroup,
        callback = function(args)
            local id = args.data.client_id
            local value = args.data.params.value
            local name = vim.lsp.get_client_by_id(id).name

            status.name = ("[%s]"):format(name)
            status.message = format_progress(value)

            local is_done = value.kind == "end"
            status.running = not is_done
            if status.running then spin() end
        end,
    })
end

return M
