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
end

return M
