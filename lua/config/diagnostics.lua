local icons = require "icons"

vim.diagnostic.config {
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
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
    },
}

-- Diagnostic icons
local sign = vim.fn.sign_define
sign("DiagnosticSignError", { text = icons.diagnostics.BoldError, texthl = "DiagnosticSignError" })
sign("DiagnosticSignWarn", { text = icons.diagnostics.BoldWarning, texthl = "DiagnosticSignWarn" })
sign("DiagnosticSignInfo", { text = icons.diagnostics.BoldInformation, texthl = "DiagnosticSignInfo" })
sign("DiagnosticSignHint", { text = icons.diagnostics.BoldHint, texthl = "DiagnosticSignHint" })

-- Undercurl for diagnostics
vim.cmd.highlight("DiagnosticUnderlineError guisp=#ff0000 gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineWarn guisp=#FFA500 gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineInfo guisp=#00FFFF gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineHint guisp=#00FF00 gui=undercurl")
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.cmd("highlight DiagnosticError guisp=#FF0000 gui=undercurl")
        vim.cmd("highlight DiagnosticWarn guisp=#FFA500 gui=undercurl")
        vim.cmd("highlight DiagnosticInfo guisp=#00FFFF gui=undercurl")
        vim.cmd("highlight DiagnosticHint guisp=#00FF00 gui=undercurl")
    end,
})
