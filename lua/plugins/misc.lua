return {
    -- Autosession / restore session
    {
        "rmagatti/auto-session",
        config = require("utils.configs").configure("misc.auto-session"),
        lazy = false,
    },

    -- Autoclose parentheses, brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    -- Tag autoclose
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            })
        end,
    },

    -- High-performance color highlighter
    {
        "norcalli/nvim-colorizer.lua",
        config = true,
    },

    -- Comment multiple lines
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    -- Detect tabstop and shiftwidth automatically
    {
        "Darazaki/indent-o-matic",
        config = function()
            require("indent-o-matic").setup({
                -- The values indicated here are the defaults
                -- Number of lines without indentation before giving up (use -1 for infinite)
                max_lines = 2048,

                -- Space indentations that should be detected
                standard_widths = { 2, 4, 8 },

                -- Skip multi-line comments and strings (more accurate detection but less performant)
                skip_multiline = true,
            })
        end,
    },

    -- Visual mutiline edit
    {
        "mg979/vim-visual-multi",
    },

    -- Scoped tabs
    {
        "tiagovla/scope.nvim",
        config = true,
    },

    -- Pretty quick list fix
    {
        "yorickpeterse/nvim-pqf",
        config = function()
            require("pqf").setup()
        end,
    },

    -- Sorround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },

    -- Tmux & split window navigation
    {
        "christoomey/vim-tmux-navigator",
    },

    -- Undo Tree
    {
        "mbbill/undotree",
    },

    -- yank cycle and picker
    -- needs to be loaded after snacks
    {
        "gbprod/yanky.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = require("utils.configs").configure("misc.yanky"),
    },
}
