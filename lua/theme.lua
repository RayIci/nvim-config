mnvim.plugins.install({
    {
        "rose-pine/neovim",
        name = "rose pine",
    },
    {
        "Mofiqul/vscode.nvim",
        name = "vscode",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },
    {
        "joshdick/onedark.vim",
        name = "onedark",
    },
    {
        "sainnhe/sonokai",
        name = "sonokai",
    },
    {
        "projekt0n/github-nvim-theme",
        name = "github",
    },
    -- {
    --     "olimorris/onedarkpro.nvim",
    --     name = "onedarkpro",
    -- },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
    },
    {
        "lunarvim/darkplus.nvim",
        name = "darkplus",
    },
    {
        "scottmckendry/cyberdream.nvim",
        name = "cyberdream",
        config = function()
            require("cyberdream").setup({})
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
    },
    {
        "sainnhe/gruvbox-material",
        name = "gruvbox-material",
    },
    {
        "loctvl842/monokai-pro.nvim",
        name = "monokai-pro",
    },
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
    },
})

-- set the foldcolumn background to match the current colorscheme
local function set_foldcolumn_match_bg()
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none", fg = "none" })
end
set_foldcolumn_match_bg()
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_foldcolumn_match_bg,
})
