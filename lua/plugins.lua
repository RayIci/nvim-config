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
