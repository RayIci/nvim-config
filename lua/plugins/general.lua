return {
    -- Better keys handling
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = require("configs.plugins.general.which-key").opts,
        keys = require("configs.plugins.general.which-key").keys,
    },

    -- Folder tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        config = require("utils.configs").configure("general.neotree"),
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
            {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                config = function()
                    require("window-picker").setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { "terminal", "quickfix" },
                            },
                        },
                    })
                end,
            },
        },
    },

    -- Buffer pages
    {
        "akinsho/bufferline.nvim",
        config = require("utils.configs").configure("general.bufferline"),
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "moll/vim-bbye",
        },
    },

    -- Telescope for file finding and others
    {
        "nvim-telescope/telescope.nvim",
        config = require("utils.configs").configure("general.telescope"),
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
    },
}
