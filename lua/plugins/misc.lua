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
}
