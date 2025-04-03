return {
    -- DAP ui
    {
        "rcarriga/nvim-dap-ui",
        config = require("utils.configs").configure("ui.dapui"),
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
    },

    -- Dessing for floating input and choosable windows
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },

    -- Indent blankline for indentation lines
    {
        "lukas-reineke/indent-blankline.nvim",
        config = require("utils.configs").configure("ui.indent-blankline"),
        main = "ibl",
    },

    -- Lightbulb for code actions and lenses
    {
        "kosayoda/nvim-lightbulb",
        config = require("utils.configs").configure("ui.lightbulb"),
    },

    -- lualine for crazy bottom line
    {
        "nvim-lualine/lualine.nvim",
        config = require("utils.configs").configure("ui.lualine"),
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "yavorski/lualine-macro-recording.nvim" },
        },
    },

    -- Noice for some amazing functionalities
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = require("utils.configs").configure("ui.noice"),
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    -- Notify for notifications
    {
        "rcarriga/nvim-notify",
        config = require("utils.configs").configure("ui.notify"),
    },

    -- Theme switcher
    {
        "vague2k/huez.nvim",
        config = require("utils.configs").configure("ui.themery"),
        branch = "stable",
        -- event = "UIEnter",
    },
}
