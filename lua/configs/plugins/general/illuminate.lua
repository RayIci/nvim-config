require("illuminate").configure({
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    delay = 120,
    filetypes_denylist = { "NvimTree", "packer", "lazy" },
    under_cursor = true,
})

local map = require("utils.keymaps").map
map("n", "<c-f>", require("illuminate").goto_next_reference, { desc = "Next reference" })
map("n", "<c-g>", require("illuminate").goto_prev_reference, { desc = "Previous reference" })
