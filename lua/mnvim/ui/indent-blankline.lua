----------------------------------------------------------------------
--- Indent Blankline
----------------------------------------------------------------------
_G.mnvim.indentation = {}

---@type string char used as indent chart
mnvim.indentation.indent_char = mnvim.ui.icons.ui.LineDashedIndent
---@type string[] list of filetypes to exclude
mnvim.indentation.exclude_filetypes = {}

local default_exclude_filetypes = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
}

mnvim.plugins.install({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup({
            exclude = {
                filetypes = require("mnvim.utils.tables").concat_lists(default_exclude_filetypes, mnvim.indentation.exclude_filetypes),
            },
            scope = {
                show_start = false,
                show_end = false,
                show_exact_scope = false,
            },
            indent = {
                char = mnvim.indentation.indent_char,
            },
        })
    end,
    main = "ibl",
})
