local icons = require("utils.icons")
require("ibl").setup({
    exclude = {
        filetypes = {
            "help",
            "startify",
            "dashboard",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
        },
    },
    scope = {
        show_start = false,
        show_end = false,
        show_exact_scope = false,
    },
    indent = {
        char = icons.ui.LineDashedIndent, -- ┊, -- ┊ ⠇ ¦ ▏ -- https://www.compart.om/en/unicode/U+250A
    },
})
