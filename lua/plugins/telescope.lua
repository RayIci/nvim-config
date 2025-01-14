local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
}

function M.config()
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    require("telescope").setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-g>"] = "which_key",
                    ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    ["<C-j>"] = require("telescope.actions").move_selection_next,
                    ["<C-l>"] = require("telescope.actions").select_default,
                    ["<C-v>"] = require("telescope.actions").select_vertical,
                    ["<C-h>"] = require("telescope.actions").select_horizontal,
                    ["<C-t>"] = open_with_trouble,
                    ["<C-a>"] = add_to_trouble,
                },
                n = {
                    ["<C-t>"] = open_with_trouble,
                    ["<C-a>"] = add_to_trouble,
                },
            },
        },
        pickers = {
            find_files = {
                file_ignore_patterns = { "node_modules", "^.git", ".venv", "__pycache__", ".pytest_cache" },
                hidden = true,
            },
        },
        live_grep = {
            file_ingore_patterns = { "node_modules", "^.git", ".venv", "__pycache__", ".pytest_cache" },
            additional_args = function(_)
                return { "--hidden" }
            end,
        },
    })
end

return M
