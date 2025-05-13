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
