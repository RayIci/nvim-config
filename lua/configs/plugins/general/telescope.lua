-- KEYMAPS --
require("which-key").add({
    { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>f", group = "Find" },
    { "<leader>fg", require("telescope").extensions.live_grep_args.live_grep_args, desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope resume<cr>", desc = "File resume" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todos" },
})

local files_file_ingore_by_pattern = {}
local grep_file_ingore_patterns = {}
local common_file_ignore_patterns = {
    "%.ropeproject/",
    "node_modules",
    "%.git/",
    "%.venv.*/",
    "__pycache__",
    ".pytest_cache",
}

-- Telescope actions
local actions = require("telescope.actions")

-- Trouble extension
-- local open_with_trouble = require("trouble.sources.telescope").open
-- local add_to_trouble = require("trouble.sources.telescope").add

-- SETUP --
require("telescope").setup({
    defaults = {
        border = true,
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

                -- ["<C-t>"] = open_with_trouble,
                -- ["<C-a>"] = add_to_trouble,
            },
            n = {
                ["<C-n>"] = require("telescope.actions").preview_scrolling_down,
                ["<C-p>"] = require("telescope.actions").preview_scrolling_up,

                -- ["<C-t>"] = open_with_trouble,
                -- ["<C-a>"] = add_to_trouble,
            },
        },
    },
    pickers = {
        find_files = {
            file_ignore_patterns = require("utils.tables").concat_tables(
                common_file_ignore_patterns,
                files_file_ingore_by_pattern
            ),
            hidden = true,
        },
    },
    live_grep = {
        file_ingore_patterns = require("utils.tables").concat_tables(
            common_file_ignore_patterns,
            grep_file_ingore_patterns
        ),
        additional_args = function(_)
            return { "--hidden" }
        end,
    },
})

-- Telescope Extensions
local telescope = require("telescope")
telescope.load_extension("live_grep_args") -- Add live grep arguments to telescope file grep
