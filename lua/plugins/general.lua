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

    -- Refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        config = require("utils.configs").configure("general.refactoring"),
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {
            modes = {
                symbols = {
                    win = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.4,
                    },
                },
            },
        },
    },

    -- Toggleterm
    {

        "akinsho/toggleterm.nvim",
        config = require("utils.configs").configure("general.toggleterm"),
    },

    -- Replacer
    {
        "nvim-pack/nvim-spectre",
        config = require("utils.configs").configure("general.nvim-specter"),
    },

    -- Replacer
    {
        "rest-nvim/rest.nvim",
        opts = require("configs.plugins.general.rest").opts,
        config = function() end,
    },

    -- Lspsaga
    {
        "nvimdev/lspsaga.nvim",
        config = require("utils.configs").configure("general.lspsaga"),
    },

    -- Illuminate
    {
        "RRethy/vim-illuminate",
        config = require("utils.configs").configure("general.illuminate"),
    },

    -- Easy motion
    {
        "easymotion/vim-easymotion",
        config = require("utils.configs").configure("general.easymotion"),
    },

    -- Doge docstring generate
    {
        "kkoomen/vim-doge",
        build = ":call doge#install()",
        config = require("utils.configs").configure("general.doge"),
    },

    {
        "max397574/better-escape.nvim",
        config = require("utils.configs").configure("general.better-escape"),
    },

    -- Snacks for a collection of useful plugins
    {
        "folke/snacks.nvim",
        keys = require("configs.plugins.general.snacks").keys,
        opts = {
            scratch = require("configs.plugins.general.snacks").scratch,
            statuscolumn = { enabled = false },
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = false },
            picker = { enabled = false },
            notifier = { enabled = false },
            quickfile = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            words = { enabled = false },
        },
    },
}
