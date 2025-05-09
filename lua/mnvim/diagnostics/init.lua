local M = {}
local icons = mnvim.ui.icons

_G.mnvim.diagnostics = {}

mnvim.diagnostics.icons = {}
mnvim.diagnostics.icons.error = icons.diagnostics.Error
mnvim.diagnostics.icons.warning = icons.diagnostics.Warning
mnvim.diagnostics.icons.info = icons.diagnostics.Information
mnvim.diagnostics.icons.hint = icons.diagnostics.Hint
mnvim.diagnostics.icons.sign_error = icons.diagnostics.BoldError
mnvim.diagnostics.icons.sign_warning = icons.diagnostics.BoldWarning
mnvim.diagnostics.icons.sign_info = icons.diagnostics.BoldInformation
mnvim.diagnostics.icons.sign_hint = icons.diagnostics.BoldHint

mnvim.diagnostics.virtual_text_enabled = true
mnvim.diagnostics.update_in_insert = true
mnvim.diagnostics.underline = false
mnvim.diagnostics.severity_sort = true

mnvim.diagnostics.float = {}
mnvim.diagnostics.float.focusable = true
mnvim.diagnostics.float.border = "rounded"
mnvim.diagnostics.float.style = "minimal"
mnvim.diagnostics.float.header = ""
mnvim.diagnostics.float.prefix = ""

mnvim.diagnostics.actions = {}
mnvim.diagnostics.actions.open_float = vim.diagnostic.open_float
mnvim.diagnostics.actions.next_diagnostics = vim.diagnostic.goto_next
mnvim.diagnostics.actions.prev_diagnostics = vim.diagnostic.goto_prev
mnvim.diagnostics.actions.next_error = function ()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end
mnvim.diagnostics.actions.prev_error = function ()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end
mnvim.diagnostics.actions.next_warning = function ()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end
mnvim.diagnostics.actions.prev_warning = function ()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end
mnvim.diagnostics.actions.next_info = function ()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
end
mnvim.diagnostics.actions.prev_info = function ()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.INFO })
end
mnvim.diagnostics.actions.next_hint = function ()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
end
mnvim.diagnostics.actions.prev_hint = function ()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT })
end

function M.config()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = mnvim.diagnostics.icons.error,
                [vim.diagnostic.severity.WARN] = mnvim.diagnostics.icons.warning,
                [vim.diagnostic.severity.HINT] = mnvim.diagnostics.icons.hint,
                [vim.diagnostic.severity.INFO] = mnvim.diagnostics.icons.info
            },
        },
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = mnvim.diagnostics.float,

    })

    -- Diagnostic icons
    local sign = vim.fn.sign_define
    sign("DiagnosticSignError", { text = icons.diagnostics.BoldError, texthl = "DiagnosticSignError" })
    sign("DiagnosticSignWarn", { text = icons.diagnostics.BoldWarning, texthl = "DiagnosticSignWarn" })
    sign("DiagnosticSignInfo", { text = icons.diagnostics.BoldInformation, texthl = "DiagnosticSignInfo" })
    sign("DiagnosticSignHint", { text = icons.diagnostics.BoldHint, texthl = "DiagnosticSignHint" })
end

return M
