local M = {}

local formatters = {}
---Change the default options for a formatter
---@param formatter string
---@param opts table
function M.configure_formatter(formatter, opts)
    formatters[formatter] = opts
end

local formatters_by_ft = {}
---Register a formatter or multiple one for a filetype
---@param filetype string The filetype where the formatter will be registered for
---@param formatter string|string[] The formatter or list of formatters
---@param opts table|nil Other options
function M.register_for_filetype(filetype, formatter, opts)
    opts = opts or {}

    if type(formatter) == "string" then
        formatter = { formatter }
    end

    if formatters_by_ft[filetype] == nil then
        formatters_by_ft[filetype] = {}
    end

    formatters_by_ft[filetype] = require("mnvim.utils.tables").concat_lists(formatters_by_ft[filetype], formatter, opts)
end

-- Configure conform
function M.config()
    local format_after_save = nil
    if mnvim.code.formatters.format_after_save then
        format_after_save = { lsp_format = "fallback", async = true }
    end

    require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        formatters = formatters,
        timeout_ms = 0,
        format_after_save = format_after_save,
    })
end

function M.format()
    require("conform").format({ async = true, lsp_fallback = true })
end

function M.format_range()
    require("conform").format({
        async = true,
        lsp_fallback = true,
        range = {
            start = vim.api.nvim_buf_get_mark(0, "<"), -- inizio selezione visual
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"), -- fine selezione visual
        },
    })
end

return M
