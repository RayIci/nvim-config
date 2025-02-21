local M = {
    "lewis6991/gitsigns.nvim",
    dependecies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    require('gitsigns').setup {
        signs                        = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged                 = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        on_attach                    = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true, desc = "Hunk next" })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true, desc = "Hunk prev" })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            -- Actions
            require "which-key".add({ { "<leader>H", group = "Git hunk" } })
            require "which-key".add({ { "<leader>H", group = "Git hunk", mode = "v" } })
            map('n', '<leader>Hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
            map('n', '<leader>Hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
            map('v', '<leader>Hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "Stage selected lines" })
            map('v', '<leader>Hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "Reset selected lines" })
            map('n', '<leader>HS', gitsigns.stage_buffer, { desc = "Stage buffer" })
            map('n', '<leader>Hu', gitsigns.undo_stage_hunk, { desc = "Stage hunk undo" })
            map('n', '<leader>HR', gitsigns.reset_buffer, { desc = "Reset buffer" })
            map('n', '<leader>Hp', gitsigns.preview_hunk, { desc = "Hunk Preview" })
            map('n', '<leader>HB', function() gitsigns.blame_line { full = true } end, { desc = "Hunk blame line" })
            map('n', '<leader>Hb', gitsigns.toggle_current_line_blame, { desc = "Hunk toggle line blame" })
            map('n', '<leader>Hd', gitsigns.diffthis, { desc = "Hunk diff" })
            map('n', '<leader>HD', function() gitsigns.diffthis('~') end, { desc = "Hunk diff ~" })
            map('n', '<leader>Hx', "<cmd>wincmd p | q<cr>", { desc = "Hunk diff exit" })
            map('n', '<leader>HX', gitsigns.toggle_deleted, { desc = "Hunk toggle deleted" })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Hunk select" })

            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00", bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffff00", bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000", bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#008800", bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#888800", bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#880000", bg = "none" })
        end
    }
end

return M
