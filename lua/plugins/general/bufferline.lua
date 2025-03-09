local M = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        "moll/vim-bbye",
    }
}

function M.keymaps()
    require "which-key".add {
        { "<leader>xA", "<cmd>%bd|e#|bd#<cr>",          desc = "Close all but this one" },
        { "<c-left>",   "<cmd>BufferLineMovePrev<cr>",  desc = "Buffer move previous" },
        { "<c-right>",  "<cmd>BufferLineMoveNext<cr>",  desc = "Buffer move next" },
        { "<leader>bp", "<cmd>BufferTogglePin<cr>",     desc = "Pin toggle" },
        { "<tab>",      "<cmd>BufferLineCycleNext<cr>", desc = "Buffer next" },
        { "<s-tab>",    "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer previous" },
    }
end

function M.config()
    local icons = require("utils.icons")

    require("bufferline").setup {
        options = {
            mode = "buffers", -- "buffers" | "tabs"  set to "tabs" to only show tabpages instead
            themable = true,  -- allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            buffer_close_icon = icons.ui.Close,
            close_icon = icons.ui.Close,
            path_components = 1, -- Show only the file name without the directory
            modified_icon = icons.ui.Dot,
            max_name_length = 30,
            max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
            tab_size = 21,
            diagnostics = true,
            diagnostics_update_in_insert = true,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            show_tab_indicators = false,
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'icon' -- 'icon' | 'underline' | 'none',
            },
            icon_pinned = icons.ui.Pin,
            minimum_padding = 1,
            maximum_padding = 5,
            maximum_length = 15,
            sort_by = "insert_at_end",
        },
    }
    M.keymaps()
end

return M
