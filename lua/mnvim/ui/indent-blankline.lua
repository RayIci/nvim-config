local M = {}

M.exclude_filetypes = {}
M.indent_char = ""

local default_exclude_filetypes = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
}

function M.config()
    require("ibl").setup({
        exclude = {
            filetypes = require("mnvim.utils.tables").concat_lists(default_exclude_filetypes, mnvim.ui.indentation.exclude_filetypes),
        },
        scope = {
            show_start = false,
            show_end = false,
            show_exact_scope = false,
        },
        indent = {
            char = mnvim.ui.indentation.indent_char,
        },
    })
end

return M
