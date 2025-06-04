mnvim.code.formatters.register_for_filetype("markdown", "prettier")

-- PLUGIN FOR MARKDOWN RENDER ON BROWSER
mnvim.plugins.install({
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
})

-- PLUGIN FOR MARKDOWN RENDER ON NEOVIM
mnvim.plugins.install({
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        preview = {
            filetypes = { "markdown", "vimwiki", "copilot-chat" },
            ignore_buftypes = {},
        },
    },
})

local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

mapgroup("-m", "Markdown")
map("n", "-mt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle" })
map("n", "-mo", "<cmd>MarkdownPreview<cr>", { desc = "Open" })
map("n", "-ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop" })
map("n", "-mc", "<cmd>MarkdownPreviewClose<cr>", { desc = "Close" })

map("n", "-mm", "<cmd>Markview toggle<cr>", { desc = "Toggle Render Markdown" })
