local icons = require("utils.icons")

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
        },
    },
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        border = "rounded",
        style = "minimal",
        header = "",
        prefix = "",
    },
})

-- Diagnostic icons
local sign = vim.fn.sign_define
sign("DiagnosticSignError", { text = icons.diagnostics.BoldError, texthl = "DiagnosticSignError" })
sign("DiagnosticSignWarn", { text = icons.diagnostics.BoldWarning, texthl = "DiagnosticSignWarn" })
sign("DiagnosticSignInfo", { text = icons.diagnostics.BoldInformation, texthl = "DiagnosticSignInfo" })
sign("DiagnosticSignHint", { text = icons.diagnostics.BoldHint, texthl = "DiagnosticSignHint" })
