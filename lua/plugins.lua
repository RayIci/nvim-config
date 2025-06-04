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

-- CODE COMPANION | COPILOT AI
mnvim.plugins.install({
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            -- Copy images with :PasteImage
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

mnvim.code.autocompletion.add_source(1, { name = "codecompanion" })

-- COPILOT
-- mnvim.plugins.install({
--     "CopilotC-Nvim/CopilotChat.nvim",
--     dependencies = {
--         { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
--         { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
--     },
--     build = "make tiktoken", -- Only on MacOS or Linux
--     config = function()
--         mapgroup("<leader>C", "Copilot chat")
--         map({ "v", "n" }, "<leader>Cc", "<cmd>CopilotChatToggle<cr>", { desc = "Open chat toggle" })
--         map({ "v", "n" }, "<leader>Cs", "<cmd>CopilotChatStop<cr>", { desc = "Stop output" })
--         map({ "v", "n" }, "<leader>Cr", "<cmd>CopilotChatReset<cr>", { desc = "Reset output" })
--         map({ "v", "n" }, "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", { desc = "Show prompts" })
--
--         -- Github copilot keymaps
--         map("i", "<c-t>", 'copilot#Accept("\\<CR>")', { desc = "Copilot accept", expr = true, replace_keycodes = false })
--         map("i", "<c-y>", "<Plug>(copilot-accept-word)", { desc = "Copilot accept word" })
--         vim.g.copilot_no_tab_map = true
--
--         require("CopilotChat").setup({
--             mappings = {
--                 close = {
--                     normal = "q",
--                     insert = "",
--                 },
--             },
--         })
--     end,
-- })

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
        trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
        distance_stop_animating = 0.5, -- 0.1      > 0
    },
})
