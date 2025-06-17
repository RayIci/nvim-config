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
        "navarasu/onedark.nvim",
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
            require("cyberdream").setup({
                theme = "dark",
                transparent = true,
            })
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
