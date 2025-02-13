local M = {
    'romgrk/barbar.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
}

function M.config()
    local icons = require "icons"

    require 'barbar'.setup {
        -- Enable/disable animations
        animation = true,

        -- Automatically hide the tabline when there are this many buffers left.
        -- Set to any value >=0 to enable.
        auto_hide = false,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,

        -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
        -- Valid options are 'left' (the default), 'previous', and 'right'
        focus_on_close = 'left',

        -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
        hide = { extensions = true },

        -- Disable highlighting alternate buffers
        highlight_alternate = false,

        -- Disable highlighting file icons in inactive buffers
        highlight_inactive_file_icons = false,

        -- Enable highlighting visible buffers
        highlight_visible = true,

        -- If true, new buffers will be inserted at the start/end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = true,
        insert_at_start = false,

        sidebar_filetypes = {
            -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
            NvimTree = true,
            -- Or, specify the text used for the offset:
            undotree = {
                text = 'undotree',
                align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
            },
            -- Or, specify the event which the sidebar executes when leaving:
            ['neo-tree'] = { event = 'BufWipeout' },
            -- Or, specify all three
            Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
        },

        icons = {
            -- Configure the base icons on the bufferline.
            -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
            buffer_index = false,
            buffer_number = false,
            button = icons.ui.BoldClose,
            -- Enables / disables diagnostic symbols
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
                [vim.diagnostic.severity.WARN] = { enabled = false },
                [vim.diagnostic.severity.INFO] = { enabled = false },
                [vim.diagnostic.severity.HINT] = { enabled = true },
            },
            gitsigns = {
                added = { enabled = true, icon = '+' },
                changed = { enabled = true, icon = '~' },
                deleted = { enabled = true, icon = '-' },
            },
            filetype = {
                -- Sets the icon's highlight group.
                -- If false, will use nvim-web-devicons colors
                custom_colors = false,

                -- Requires `nvim-web-devicons` if `true`
                enabled = true,
            },
            separator = { left = '▌', right = '' }, -- also  '▎'

            -- If true, add an additional separator at the end of the buffer list
            separator_at_end = true,

            -- Configure the icons on the bufferline when modified or pinned.
            -- Supports all the base icon options.
            modified = { button = icons.ui.Circle },
            pinned = { button = icons.ui.Pin, filename = true },

            -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
            preset = 'default',

            -- Configure the icons on the bufferline based on the visibility of a buffer.
            -- Supports all the base icon options, plus `modified` and `pinned`.
            inactive = { button = icons.ui.BoldClose },
        },
    }
    vim.api.nvim_set_hl(0, "BufferInactive", { link = "BufferCurrent" })
end

return M
