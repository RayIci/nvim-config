mnvim.plugins.install({
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb",
    },
})

---@class GitKeymaps
---@field hunk HunkKeymaps

---@type GitKeymaps
_G.mnvim.git.keymaps = {}

---@class HunkKeymaps
---@field stage string
---@filed reset string
---@field stage_selected string
---@field reset_selected string
---@field stage_buffer string
---@field reset_buffer string
---@field undo string
---@field preview string
---@field blame_line string
---@field blame_toggle string
---@field diff string
---@field diff_tilda string
---@field diff_exit string
---@field deleted_toggle string
local hunk_keymaps = {
    stage = "<leader>Hs",
    stage_selected = "<leader>Hs",
    reset = "<leader>Hr",
    reset_selected = "<leader>Hr",
    stage_buffer = "<leader>HS",
    reset_buffer = "<leader>HR",
    undo = "<leader>HR",
    preview = "<leader>Hp",
    blame_line = "<leader>HB",
    blame_toggle = "<leader>Hb",
    diff = "<leader>Hd",
    diff_tilda = "<leader>HD",
    diff_exit = "<leader>Hx",
    deleted_toggle = "<leader>HX",
}

_G.mnvim.git.keymaps.hunk = hunk_keymaps

mnvim.plugins.install({
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged_enable = true,
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true, desc = "Hunk next" })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end)

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true, desc = "Hunk prev" })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end)

                    -- Actions
                    require("which-key").add({ { "<leader>H", group = "Git hunk" } })
                    require("which-key").add({ { "<leader>H", group = "Git hunk", mode = "v" } })
                    map("n", mnvim.git.keymaps.hunk.stage, gitsigns.stage_hunk, { desc = "Stage hunk" })
                    map("n", mnvim.git.keymaps.hunk.reset, gitsigns.reset_hunk, { desc = "Reset hunk" })

                    map("v", mnvim.git.keymaps.hunk.stage_selected, function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage selected lines" })
                    map("v", mnvim.git.keymaps.hunk.reset_selected, function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset selected lines" })

                    map("n", mnvim.git.keymaps.hunk.stage_buffer, gitsigns.stage_buffer, { desc = "Stage buffer" })
                    map("n", mnvim.git.keymaps.hunk.reset_buffer, gitsigns.reset_buffer, { desc = "Reset buffer" })

                    map("n", mnvim.git.keymaps.hunk.undo, gitsigns.undo_stage_hunk, { desc = "Stage hunk undo" })
                    map("n", mnvim.git.keymaps.hunk.preview, gitsigns.preview_hunk, { desc = "Hunk Preview" })
                    map("n", mnvim.git.keymaps.hunk.blame_line, function()
                        gitsigns.blame_line({ full = true })
                    end, { desc = "Hunk blame line" })
                    map("n", mnvim.git.keymaps.hunk.blame_toggle, gitsigns.toggle_current_line_blame, { desc = "Hunk toggle line blame" })
                    map("n", mnvim.git.keymaps.hunk.diff, gitsigns.diffthis, { desc = "Hunk diff" })
                    map("n", mnvim.git.keymaps.hunk.diff_tilda, function()
                        gitsigns.diffthis("~")
                    end, { desc = "Hunk diff ~" })
                    map("n", mnvim.git.keymaps.hunk.diff_exit, "<cmd>wincmd p | q<cr>", { desc = "Hunk diff exit" })
                    map("n", mnvim.git.keymaps.hunk.deleted_toggle, gitsigns.toggle_deleted, { desc = "Hunk toggle deleted" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk select" })
                end,
            })
        end,
    },
})

_G.mnvim.git.conflicts = {}
_G.mnvim.git.conflicts.actions = {}
_G.mnvim.git.diffview = {}
_G.mnvim.git.diffview.actions = {}
mnvim.plugins.install({
    {
        "akinsho/git-conflict.nvim",
        version = "*",
    },
    {
        "sindrets/diffview.nvim",
    },
})

mnvim.git.conflicts.actions.select_current = function()
    vim.cmd("GitConflictChooseOurs")
end
mnvim.git.conflicts.actions.select_incoming = function()
    vim.cmd("GitConflictChooseTheirs")
end
mnvim.git.conflicts.actions.select_both = function()
    vim.cmd("GitConflictChooseBoth")
end
mnvim.git.conflicts.actions.select_none = function()
    vim.cmd("GitConflictChooseNone")
end
mnvim.git.conflicts.actions.next_conflict = function()
    vim.cmd("GitConflictNextConflict")
end
mnvim.git.conflicts.actions.prev_conflict = function()
    vim.cmd("GitConflictPrevConflict")
end
mnvim.git.conflicts.actions.quickfix = function()
    vim.cmd("GitConflictListQf")
end

mnvim.git.diffview.actions.open = function()
    vim.cmd("DiffviewOpen")
end
mnvim.git.diffview.actions.close = function()
    vim.cmd("DiffviewClose")
end
mnvim.git.diffview.actions.history_files = function()
    vim.cmd("DiffviewFileHistory")
end
mnvim.git.diffview.actions.history_current_file = function()
    vim.cmd("DiffviewFileHistory %")
end
mnvim.git.diffview.actions.refresh = function()
    vim.cmd("DiffviewRefresh")
end
mnvim.git.diffview.actions.files_toggle = function()
    vim.cmd("DiffviewToggleFiles")
end
mnvim.git.diffview.actions.current_file_toggle = function()
    vim.cmd("DiffviewToggleFiles %")
end
