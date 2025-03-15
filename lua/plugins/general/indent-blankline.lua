local M = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
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
            char = require("utils.icons").ui.LineMiddle
        },
    },
}

return M
