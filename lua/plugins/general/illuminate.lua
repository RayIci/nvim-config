local M = {
    "RRethy/vim-illuminate"
}

function M.config()
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

    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
        { "<C-f>", require("illuminate").goto_next_reference, desc = "Next reference" },
        { "<C-g>", require("illuminate").goto_prev_reference, desc = "Previous reference" },
    }
end

return M
