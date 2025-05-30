local lazy = require("utils.lazy")

lazy.initialize_lazy()
require("lazy").setup({
    spec = {
        lazy.lazy_folder("plugins"),
        lazy.lazy_folder("plugins.code-extra"),
        lazy.lazy_folder("plugins.themes"),

        --  Example of custom plugin
        -- lazy.lazy_custom_plugin(
        --     "~/.config/nvim/custom-plugins/python-df.nvim",
        --     function()
        --         require "python-df".setup()
        --     end
        -- )
    },
    defaults = {
        lazy = false,
    },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
