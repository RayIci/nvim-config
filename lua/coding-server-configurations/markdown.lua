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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    config = function()
        require("render-markdown").setup({
            file_types = { "markdown", "vimwiki", "copilot-chat" },
        })
    end,
})

local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

mapgroup("-m", "Markdown")
map("n", "-mt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle" })
map("n", "-mo", "<cmd>MarkdownPreview<cr>", { desc = "Open" })
map("n", "-ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop" })
map("n", "-mc", "<cmd>MarkdownPreviewClose<cr>", { desc = "Close" })

map("n", "-me", "<cmd>RenderMarkdown enable<cr>", { desc = "Enable Render Markdown" })
map("n", "-md", "<cmd>RenderMarkdown disable<cr>", { desc = "Disable Render Markdown" })
map("n", "-mr", "<cmd>RenderMarkdownToggle<cr>", { desc = "Toggle Render Markdown" })

map("n", "-mj", "<cmd>RenderMarkdown expand<cr>", { desc = "Render Markdown Expand" })
map("n", "-mk", "<cmd>RenderMarkdown contract<cr>", { desc = "Render Markdown Contract" })
