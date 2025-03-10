local M = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
}

function M.config()
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    M.keymaps()

    require("telescope").setup({
        defaults = {
            layout_strategy = "vertical",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.6,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                    preview_height = 0.4,
                    results_width = 0.6,
                },
                width = 0.9,
                height = 0.9,
            },
            prompt_prefix = "🔍 ",
            mappings = {
                i = {
                    ["<C-g>"] = "which_key",
                    ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    ["<C-j>"] = require("telescope.actions").move_selection_next,

                    ["<C-n>"] = require("telescope.actions").preview_scrolling_down,
                    ["<C-p>"] = require("telescope.actions").preview_scrolling_up,

                    ["<C-l>"] = require("telescope.actions").select_default,
                    ["<C-v>"] = require("telescope.actions").select_vertical,
                    ["<C-h>"] = require("telescope.actions").select_horizontal,

                    ["<C-t>"] = open_with_trouble,
                    ["<C-a>"] = add_to_trouble,
                },
                n = {
                    ["<C-n>"] = require("telescope.actions").preview_scrolling_down,
                    ["<C-p>"] = require("telescope.actions").preview_scrolling_up,

                    ["<C-t>"] = open_with_trouble,
                    ["<C-a>"] = add_to_trouble,
                },
            },
        },
        pickers = {
            find_files = {
                file_ignore_patterns = { "node_modules", "%.git/", "%.venv.*/", "__pycache__", ".pytest_cache" },
                hidden = true,
            },
        },
        live_grep = {
            file_ingore_patterns = { "node_modules", "%.git/", "%.venv.*/", "__pycache__", ".pytest_cache" },
            additional_args = function(_)
                return { "--hidden" }
            end,
        },
    })

    -- Telescope Extensions
    local telescope = require("telescope")
    telescope.load_extension("live_grep_args") -- Add live grep arguments to telescope file grep
end

function M.keymaps()
    require "which-key".add {
        { "<leader><leader>", "<cmd>Telescope find_files<cr>",                              desc = "Find File" },
        { "<leader>f",        group = "Find" },
        { "<leader>fg",       require 'telescope'.extensions.live_grep_args.live_grep_args, desc = "Live Grep" },
        { "<leader>fb",       "<cmd>Telescope buffers<cr>",                                 desc = "Buffers" },
        { "<leader>fh",       "<cmd>Telescope help_tags<cr>",                               desc = "Help Tags" },
        { "<leader>fn",       "<cmd>Telescope notify<cr>",                                  desc = "Notifications" },
        { "<leader>fm",       "<cmd>Telescope marks<cr>",                                   desc = "Marks" },
        { "<leader>ft",       "<cmd>TodoTelescope<cr>",                                     desc = "Todos" }
    }
end

return M
