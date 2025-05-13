mnvim.plugins.install({
    -- Sorround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = true,
    },

    -- Scoped tabs
    {
        "tiagovla/scope.nvim",
        config = true,
    },

    -- lightbulb
    {
        "kosayoda/nvim-lightbulb",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
                sign = {
                    enabled = false,
                },

                -- 2. Virtual text.
                virtual_text = {
                    text = mnvim.ui.icons.diagnostics.BoldHint,
                    lens_text = "🔎",
                    enabled = true,
                },
            })
        end,
    },

    -- Code action menu
    {
        "aznhe21/actions-preview.nvim",
    },
})
