_G.mnvim.telescope = {}
_G.mnvim.telescope.actions = {}
_G.mnvim.telescope.layout = {}

---@type string
mnvim.telescope.layout.strategy = "vertical"

mnvim.telescope.file_ignore_by_pattern = {}
mnvim.telescope.grep_ignore_by_pattern = {}

function mnvim.telescope.actions.pick_file()
    vim.cmd("Telescope find_files")
end

function mnvim.telescope.actions.grep_files()
    require("telescope").extensions.live_grep_args.live_grep_args()
end

function mnvim.telescope.actions.pick_buffer()
    vim.cmd("Telescope buffers")
end

function mnvim.telescope.actions.pick_resume()
    vim.cmd("Telescope resume")
end

function mnvim.telescope.actions.pick_help_tag()
    vim.cmd("Telescope help_tags")
end

function mnvim.telescope.actions.pick_mark()
    vim.cmd("Telescope marks")
end

local extensions = {}
---Add an extension to telescope
---@param extension_name string the name of the extension
---@param extension table the table of the extension
mnvim.telescope.extensions_add = function(extension_name, extension)
    extensions[extension_name] = extension
end

-- Telescope actions
mnvim.plugins.install({
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        extensions["ui-select"] = {
            require("telescope.themes").get_dropdown({
                winblend = 10,
                border = true,
                previewer = true,
            }),
        }
        require("telescope").setup({
            defaults = {
                border = true,
                layout_strategy = mnvim.telescope.layout.strategy,
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
            extensions = extensions,
            pickers = {
                find_files = {
                    file_ignore_patterns = mnvim.telescope.file_ignore_by_pattern,
                    hidden = true,
                },
            },
            live_grep = {
                file_ingore_patterns = mnvim.telescope.grep_ignore_by_pattern,
                additional_args = function(_)
                    return { "--hidden" }
                end,
            },
        })

        -- Telescope Extensions
        require("telescope").load_extension("live_grep_args") -- Add live grep arguments to telescope file grep
        require("telescope").load_extension("ui-select")
    end,
})
