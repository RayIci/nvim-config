_G.mnvim.explorer = {}
_G.mnvim.explorer.actions = {}

mnvim.explorer.filtered_items = {}
---@type string[]
mnvim.explorer.filtered_items.hide_by_name = {}
---@type string[]
mnvim.explorer.filtered_items.hide_by_pattern = {}
---@type string[]
mnvim.explorer.filtered_items.always_show = {}
---@type string[]
mnvim.explorer.filtered_items.never_show = {}
---@type string[]
mnvim.explorer.filtered_items.never_show_by_pattern = {}

mnvim.explorer.window = {}
---@alias Position "left" | "right"
---@type Position default explorer position
mnvim.explorer.window.position = "left"
--- @type integer default explorer width
mnvim.explorer.window.width = 60

mnvim.explorer.indent = {}
--- @type integer default indent size
mnvim.explorer.indent.size = 3

mnvim.explorer.icons = {}
mnvim.explorer.icons.folder_closed = mnvim.ui.icons.ui.ChevronShortRight
mnvim.explorer.icons.folder_open = mnvim.ui.icons.ui.ChevronShortDown
mnvim.explorer.icons.folder_empty = mnvim.ui.icons.ui.ChevronShortDown

-----------------------------------------------
-- Explorer Actions
-----------------------------------------------

mnvim.explorer.actions.open_explorer = function()
    vim.cmd("Neotree toggle")
end

mnvim.explorer.actions.open_buffer_explorer = function()
    vim.cmd("Neotree buffers")
end

mnvim.explorer.actions.open_git_explorer = function()
    vim.cmd("Neotree git_status")
end

mnvim.plugins.install({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },
    config = function()
        local explorer = mnvim.explorer

        -- TODO: Remove this and place the remaining icons into explorer icons
        local icons = mnvim.ui.icons

        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_loaded(buf) then
                        local name = vim.api.nvim_buf_get_name(buf)
                        if name:match("neo%-tree") then
                            pcall(vim.api.nvim_buf_delete, buf, { force = true })
                        end
                    end
                end
            end,
        })

        require("neo-tree").setup({
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = explorer.indent.size,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = explorer.icons.folder_closed,
                    folder_open = explorer.icons.folder_open,
                    folder_empty = explorer.icons.folder_empty,
                    provider = function(icon, node, _) -- default icon provider utilizes nvim-web-devicons if available
                        if node.type == "file" or node.type == "terminal" then
                            local success, web_devicons = pcall(require, "nvim-web-devicons")
                            local name = node.type == "terminal" and "terminal" or node.name
                            if success then
                                local devicon, hl = web_devicons.get_icon(name)
                                icon.text = devicon or icon.text
                                icon.highlight = hl or icon.highlight
                            end
                        end
                    end,
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon",
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = icons.ui.Close, -- this can only be used in the git_status source
                        renamed = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = icons.git.FileUntracked, -- ""
                        ignored = icons.git.FileIgnored, -- "",
                        unstaged = icons.git.FileUnstaged, -- "󰄱",
                        staged = icons.git.FileStaged, -- "",
                        conflict = icons.git.Merge, -- "",
                    },
                },
                -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                file_size = {
                    enabled = true,
                    width = 12, -- width of the column
                    required_width = 64, -- min width of window required to show this column
                },
                type = {
                    enabled = true,
                    width = 10, -- width of the column
                    required_width = 122, -- min width of window required to show this column
                },
                last_modified = {
                    enabled = true,
                    width = 20, -- width of the column
                    required_width = 88, -- min width of window required to show this column
                },
                created = {
                    enabled = true,
                    width = 20, -- width of the column
                    required_width = 110, -- min width of window required to show this column
                },
                symlink_target = {
                    enabled = false,
                },
            },
            -- A list of functions, each representing a global custom command
            -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
            -- see `:h neo-tree-custom-commands-global`
            commands = {
                -- TODO: Refactor this. It should get the possibility to add custom commands
                --       and custom mappings from mnvim global variable

                -- TODO: Move it as soon as the refactor is done to plugins where avante is defined
                prova = function(state)
                    vim.print(state)
                end,
                avante_add_files = function(state)
                    local node = state.tree:get_node()
                    local filepath = node:get_id()
                    local relative_path = require("avante.utils").relative_path(filepath)

                    local sidebar = require("avante").get()

                    local open = sidebar:is_open()
                    -- ensure avante sidebar is open
                    if not open then
                        require("avante.api").ask()
                        sidebar = require("avante").get()
                    end

                    sidebar.file_selector:add_selected_file(relative_path)

                    -- remove neo tree buffer
                    if not open then
                        sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
                    end
                end,
            },
            window = {
                position = explorer.window.position,
                width = explorer.window.width,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    -- TODO: Refactor to add possibility to add custom mappings from mnvim global variable

                    -- TODO: Move it as soon as the refactor is done to plugins where avante is defined
                    ["oa"] = { "avante_add_files", config = { title = "Avante Add Files", prefix_key = "oa" } },

                    ["op"] = { "prova", config = { title = "Prova", prefix_key = "op" } },

                    ["<space>"] = { "toggle_node", nowait = false }, -- nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                    ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } }, -- Read `# Preview Mode` for more information
                    ["l"] = "focus_preview",
                    ["S"] = "open_split", -- ["S"] = "split_with_window_picker",
                    ["s"] = "open_vsplit", -- ["s"] = "vsplit_with_window_picker",
                    ["t"] = "open_tabnew", -- ["<cr>"] = "open_drop", -- ["t"] = "open_tab_drop",
                    ["w"] = "open_with_window_picker", --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                    ["C"] = "close_node", -- ['C'] = 'close_all_subnodes',
                    ["z"] = "close_all_nodes", --["Z"] = "expand_all_nodes",
                    -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    ["a"] = { "add", config = { show_path = "none" } }, -- "none", "relative", "absolute"
                    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                    ["d"] = "delete",
                    ["r"] = "rename", -- ["b"] = "rename_basename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                    -- ["c"] = {
                    --  "copy",
                    --  config = {
                    --    show_path = "none" -- "none", "relative", "absolute"
                    --  }
                    --}
                    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    ["i"] = "show_file_details",
                    ["Y"] = function(state)
                        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                        local node = state.tree:get_node()
                        local filepath = node:get_id()
                        local filename = node.name
                        local modify = vim.fn.fnamemodify

                        local results = {
                            filename,
                            modify(filename, ":r"),
                            filepath,
                            modify(filepath, ":."),
                            modify(filepath, ":~"),
                            modify(filename, ":e"),
                        }

                        vim.ui.select({
                            "1. Filename: " .. results[1],
                            "2. Filename without extension: " .. results[2],
                            "3. Absolute path: " .. results[3],
                            "4. Path relative to CWD: " .. results[4],
                            "5. Path relative to HOME: " .. results[5],
                            "6. Extension of the filename: " .. results[6],
                        }, { prompt = "Choose to copy to clipboard:" }, function(choice)
                            if choice ~= nil then
                                local i = tonumber(choice:sub(1, 1))
                                local result = results[i]
                                vim.fn.setreg("+", result)
                                vim.fn.setreg("*", result)
                                vim.fn.setreg('"', result)
                                vim.notify("Copied: " .. result)
                            end
                        end)
                    end,
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false, -- only works on Windows for hidden files/directories
                    hide_by_name = explorer.filtered_items.hide_by_name,
                    hide_by_pattern = explorer.filtered_items.hide_by_pattern,
                    always_show = explorer.filtered_items.always_show,
                    never_show = explorer.filtered_items.never_show,
                    never_show_by_pattern = explorer.filtered_items.never_show_by_pattern,
                },
                follow_current_file = {
                    enabled = false, -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["og"] = { "order_by_git_status", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                        -- ['<key>'] = function(state) ... end,
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                        -- ['<key>'] = function(state, scroll_padding) ... end,
                    },
                },

                commands = {}, -- Add a custom command or override a global one using the same function name
            },
            buffers = {
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    --              -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                },
            },
        })
    end,
})
