local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- ILLUMINATE
mnvim.plugins.install({
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 120,
            filetypes_denylist = { "NvimTree", "packer", "lazy" },
            under_cursor = true,
        })

        map("n", "<c-f>", require("illuminate").goto_next_reference, { desc = "Next reference" })
        map("n", "<c-g>", require("illuminate").goto_prev_reference, { desc = "Previous reference" })
    end,
})

-- EASY MOTION
mnvim.plugins.install({
    "easymotion/vim-easymotion",
    config = function()
        mapgroup("<leader>w", "Easy motions")
        map("n", "<leader>ws", "<Plug>(easymotion-s2)", { desc = "Easymotion search" })
        map("n", "<leader>wS", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion search overwin" })
        map("n", "<leader>wf", "<Plug>(easymotion-bd-f)", { desc = "Find char on current line" })
        map("n", "<leader>ww", "<Plug>(easymotion-bd-w)", { desc = "Skip word" })
        map("n", "<leader>we", "<Plug>(easymotion-bd-e)", { desc = "Skip word end" })
        map("n", "<leader>wl", "<Plug>(easymotion-lineforward)", { desc = "End of line" })
        map("n", "<leader>wh", "<Plug>(easymotion-linebackward)", { desc = "Start of line" })
    end,
})

-- DOGE: docstring generate
mnvim.plugins.install({
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    config = function()
        vim.g.doge_enable_mappings = 1
        vim.g.doge_comment_type = "auto"
        vim.g.doge_doc_standard_python = "reST"

        map("n", "<leader>G", "<Plug>(doge-generate)", { desc = "Docstring Generate" })
    end,
})

-- TROUBLE
mnvim.plugins.install({
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        modes = {
            symbols = {
                win = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.4,
                },
            },
        },
    },
})

mapgroup("<leader>k", "Trouble")
map("n", "<leader>kw", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "All windows" })
map("n", "<leader>ks", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols list" })
map("n", "<leader>kl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
map("n", "<leader>kq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })
map("n", "<leader>kd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostic toggle" })
map("n", "<leader>kD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostic buffer toggle" })

-- SPECTER: find replace
mnvim.plugins.install({
    "nvim-pack/nvim-spectre",
    config = function()
        mapgroup("<leader>S", "Finder")
        map("n", "<leader>Ss", "<cmd>lua require('spectre').toggle()<cr>", { desc = "Specter toggle" })
        map("n", "<leader>Sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Specter search word" })
        -- TODO: Should review since not working
        -- map("v", "<leader>Sw", "<esc><cmd>lua require('spectre').open_visual()<CR>", { desc = "Specter search selected word" })
        map("n", "<leader>Sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Specter search in file" })
    end,
})

-- BETTER ESCAPE
mnvim.plugins.install({
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            default_mappings = false,
            mappings = {
                i = {
                    j = {
                        -- These can all also be functions
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                },
                c = {},
                t = {},
                v = {},
                s = {},
            },
        })
    end,
})

-- COPILOT (AUTOSUGGESTIONS)
mnvim.plugins.install({
    "github/copilot.vim",
    config = function()
        -- Github copilot keymaps
        map("i", "<c-t>", 'copilot#Accept("\\<CR>")', { desc = "Copilot accept line", expr = true, replace_keycodes = false })
        map("i", "<c-y>", "<Plug>(copilot-accept-word)", { desc = "Copilot accept word" })
        vim.g.copilot_no_tab_map = true
    end,
})

-- COPILOT CHAT
mnvim.plugins.install({
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "github/copilot.vim" },
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function()
        mapgroup("<leader>C", "Copilot chat")
        map({ "v", "n" }, "<leader>Cc", "<cmd>CopilotChatToggle<cr>", { desc = "Open chat toggle" })
        map({ "v", "n" }, "<leader>Cs", "<cmd>CopilotChatStop<cr>", { desc = "Stop output" })
        map({ "v", "n" }, "<leader>Cr", "<cmd>CopilotChatReset<cr>", { desc = "Reset output" })
        map({ "v", "n" }, "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", { desc = "Show prompts" })

        require("CopilotChat").setup({
            mappings = {
                -- model = "claude-3.7-sonnet",
                close = {
                    normal = "q",
                    insert = "",
                },
                show_diffs = {
                    full_diff = true,
                },
            },
        })
    end,
})

-- MINI DIFF: Used for Code Companion
mnvim.plugins.install({
    "echasnovski/mini.diff",
    config = function()
        require("mini.diff").setup({
            source = require("mini.diff").gen_source.none(),
            enable = true,
            -- source = require("mini.diff").gen_source.none(),
            view = {
                signs = {
                    add = "+",
                    change = "~",
                    delete = "-",
                },
            },
            mappings = {
                -- Apply hunks inside a visual/operator region
                apply = "gh",

                -- Reset hunks inside a visual/operator region
                reset = "gH",

                -- Hunk range textobject to be used inside operator
                -- Works also in Visual mode if mapping differs from apply and reset
                textobject = "gh",

                -- Go to hunk range in corresponding direction
                goto_first = "[H",
                goto_prev = "[p",
                goto_next = "]p",
                goto_last = "]H",
            },
        })
    end,
})

-- CODE COMPANION: AI code companion
-- needs:
--  uv: https://docs.astral.sh/uv/getting-started/installation/#installation-methods
--  vectorcode: https://github.com/Davidyz/VectorCode/blob/main/docs/cli.md#installation
--  pipx: https://github.com/pypa/pipx
--  mcp-hub: https://ravitemer.github.io/mcphub.nvim/installation.html
mnvim.plugins.install({
    "olimorris/codecompanion.nvim",
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = {
                        ----------------------------
                        name = "copilot",
                        model = "gpt-4.1",
                        ----------------------------
                        --- name = "ollama",
                        --- model = "qwen2.5-coder:7b",
                        ----------------------------
                    },
                    keymaps = {
                        close = {
                            modes = {
                                n = "<c-q>",
                                i = "nil",
                            },
                        },
                    },
                },
                inline = {
                    adapter = "copilot",
                    -- model = "qwen2.5-coder:7b",
                },
                cmd = {
                    adapter = "copilot",
                    -- model = "qwen2.5-coder:7b",
                },
            },
            adapters = {
                opts = {
                    show_model_choices = true,
                },
                -- Define your custom adapters here
            },
            display = {
                -- Change degault diff provider
                diff = {
                    provider = "mini_diff", -- default|mini_diff
                },
                chat = {
                    show_settings = true,
                },
            },
            prompt_library = {
                ["Boilerplate HTML"] = {
                    strategy = "inline",
                    description = "Generate some boilerplate HTML",
                    opts = {
                        mapping = "<leader>ao",
                    },
                    prompts = {
                        {
                            role = "system",
                            content = "You are an expert HTML programmer",
                        },
                        {
                            role = "user",
                            content = "<user_prompt>Please generate some HTML boilerplate for me. Return the code only and no markdown codeblocks</user_prompt>",
                        },
                    },
                },
            },
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        keymap = "<leader>ah",
                        save_chat_keymap = "<leader>as",
                        auto_save = true,
                        auto_generate_title = true,
                        continue_last_chat = false,
                        delete_on_clearing_chat = false,
                        picker = "snacks",
                        enable_logging = false,
                        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                    },
                },
                vectorcode = {
                    opts = {
                        add_tool = true,
                    },
                },
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true,
                    },
                },
            },
        })

        mapgroup("<leader>a", "Code Companion")
        map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "Open the action palette" })
        map({ "n", "v" }, "<leader>an", "<cmd>CodeCompanionChat<cr>", { desc = "New chat buffer" })
        map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle chat buffer" })
        map({ "v" }, "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to chat buffer" })
        map("v", "<leader>ai", function()
            vim.fn.feedkeys(":CodeCompanion ")
        end, { desc = "Ask for input and send to CodeCompanion" })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
        "stevearc/dressing.nvim",
        {
            "ravitemer/mcphub.nvim", -- Manage MCP servers
            cmd = "MCPHub",
            build = "npm install -g mcp-hub@latest",
            config = true,
        },
        {
            "Davidyz/VectorCode", -- Index and search code in your repositories
            version = "*",
            build = "pipx upgrade vectorcode",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
            "HakonHarnes/img-clip.nvim",
            opts = {
                filetypes = {
                    codecompanion = {
                        prompt_for_file_name = false,
                        template = "[Image]($FILE_PATH)",
                        use_absolute_path = true,
                    },
                },
            },
        },
    },
})

-- YANKY
mnvim.plugins.install({
    "gbprod/yanky.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
        require("yanky").setup({})

        map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Paste after" })
        map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Paste before" })
        map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Paste g after" })
        map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Paste g before" })

        map("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "Cycle previous yank" })
        map("n", "<c-y>", "<Plug>(YankyNextEntry)", { desc = "Cycle next yank" })
        map({ "n", "x" }, "<leader>p", Snacks.picker.yanky, { desc = "Yank select" })
    end,
})

-- BETTER QF
mnvim.plugins.install({
    "yorickpeterse/nvim-pqf",
    config = function()
        require("pqf").setup()
    end,
})

-- SMOOTH CURSOR
mnvim.plugins.install({
    "sphamba/smear-cursor.nvim",
    opts = {
        -- stiffness = 0.5,
        -- trailing_stiffness = 0.49,

        stiffness = 0.8, -- 0.6      [0, 1]
        trailing_stiffness = 0.5, -- 0.4      [0, 1]
        stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
        trailing_stiffness_insert_mode = 0.6, -- 0.4      u0, 1u
        distance_stop_animating = 0.5, -- 0.1      > 0
    },
})

-- UFO: folding plugin
mnvim.plugins.install({
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" },
    config = function()
        require("ufo").setup({
            close_fold_kinds_for_ft = {},
            close_fold_kinds = {},
            open_fold_hl_timeout = 10,
            enable_get_fold_virt_text = true,
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })

        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            ft_ignore = { "neo-tree", "neotree" },
            setopt = true,
            relculright = true,
            segments = {
                { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
                { text = { "%s" }, click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
        })

        vim.o.foldcolumn = "1" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.opt.fillchars = {
            fold = " ",
            foldopen = mnvim.ui.icons.ui.ChevronShortDown,
            foldclose = mnvim.ui.icons.ui.ChevronRight,
            foldsep = " ",
        }

        map("n", "zR", require("ufo").openAllFolds, { desc = "Open folds" })
        map("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Fold less" })
        map("n", "zM", require("ufo").closeAllFolds, { desc = "Close folds" })
        map("n", "zm", require("ufo").closeFoldsWith, { desc = "Fold more" })
    end,
})

-- BACKUP PLUGINS ---------------------------------------------------------------------------------
--
-- AVANTE: AI code completion
-- mnvim.plugins.install({
--     "yetone/avante.nvim",
--     event = "VeryLazy",
--     version = false,
--     opts = {
--         mode = "legacy", -- "legacy" | "agentic"
--         provider = "ollama", -- "ollama" | "copilot"
--         providers = {
--             copilot = {
--                 model = "claude-3.7-sonnet",
--             },
--             ollama = {
--                 -- model = "qwen2.5-coder:14b",
--                 model = "qwen2.5-coder:7b",
--             },
--         },
--         mappings = {
--             diff = {
--                 ours = "co",
--                 theirs = "ct",
--                 all_theirs = "ca",
--                 both = "cb",
--                 cursor = "cc",
--                 next = "]x",
--                 prev = "[x",
--             },
--             suggestion = {
--                 accept = "<M-l>",
--                 next = "<M-]>",
--                 prev = "<M-[>",
--                 dismiss = "<C-]>",
--             },
--             jump = {
--                 next = "]]",
--                 prev = "[[",
--             },
--             submit = {
--                 normal = "<CR>",
--                 insert = "<C-o>",
--             },
--             cancel = {
--                 normal = { "<C-c>", "<Esc>", "q" },
--                 insert = { "<C-c>" },
--             },
--             sidebar = {
--                 apply_all = "A",
--                 apply_cursor = "a",
--                 retry_user_request = "r",
--                 edit_user_request = "e",
--                 switch_windows = "<Tab>",
--                 reverse_switch_windows = "<S-Tab>",
--                 remove_file = "d",
--                 add_file = "@",
--                 close = { "<Esc>", "q" },
--                 close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
--             },
--         },
--         windows = {
--             width = 45,
--             input = {
--                 prefix = "> ",
--                 height = 8,
--             },
--             edit = {
--                 start_insert = true,
--             },
--             ask = {
--                 start_insert = false,
--             },
--         },
--     },
--
--     -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--     build = "make",
--     -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--     dependencies = {
--         "nvim-treesitter/nvim-treesitter",
--         "nvim-lua/plenary.nvim",
--         "MunifTanjim/nui.nvim",
--         --- The below dependencies are optional,
--         "echasnovski/mini.pick", -- for file_selector provider mini.pick
--         "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
--         "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
--         "ibhagwan/fzf-lua", -- for file_selector provider fzf
--         "stevearc/dressing.nvim", -- for input provider dressing
--         "folke/snacks.nvim", -- for input provider snacks
--         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--         {
--             "zbirenbaum/copilot.lua",
--             config = function()
--                 require("copilot").setup({
--                     -- copilot_model = "claude-3.7-sonnet",
--                     suggestion = {
--                         enabled = true,
--                         auto_trigger = true,
--                         keymap = {
--                             prev = "<c-[>",
--                             next = "<c-]>",
--                             dismiss = "<c-a>",
--                         },
--                     },
--                     panel = {
--                         enabled = false,
--                     },
--                 })
--
--                 map("i", "<c-t>", require("copilot.suggestion").accept_line, { desc = "Copilot accept line" })
--                 map("i", "<c-y>", require("copilot.suggestion").accept_word, { desc = "Copilot accept word" })
--             end,
--         },
--         {
--             -- support for image pasting
--             "HakonHarnes/img-clip.nvim",
--             event = "VeryLazy",
--             opts = {
--                 -- recommended settings
--                 default = {
--                     embed_image_as_base64 = false,
--                     prompt_for_file_name = false,
--                     drag_and_drop = {
--                         insert_mode = true,
--                     },
--                     -- required for Windows users
--                     use_absolute_path = true,
--                 },
--             },
--         },
--     },
-- })
