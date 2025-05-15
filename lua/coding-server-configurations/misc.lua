mnvim.code.packages.install("formatter", "prettier")
mnvim.code.formatters.register_for_filetype("markdown", "prettier")
mnvim.code.formatters.register_for_filetype("json", "prettier")
mnvim.code.formatters.register_for_filetype("yaml", "prettier")

mnvim.plugins.install({
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
})

local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

mapgroup("-m", "Markdown")
mapgroup("-mp", "Preview")
map("n", "-mpt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle" })
map("n", "-mpo", "<cmd>MarkdownPreview<cr>", { desc = "Open" })
map("n", "-mps", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop" })
map("n", "-mpc", "<cmd>MarkdownPreviewClose<cr>", { desc = "Close" })
