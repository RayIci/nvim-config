local M = {
    "easymotion/vim-easymotion"
}

function M.config()
    vim.g.EasyMotion_do_mapping = 0
    vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s2)", {})
    vim.api.nvim_set_keymap("n", "S", "<Plug>(easymotion-overwin-f2)", {})
    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
        { "s",                 "<Plug>(easymotion-s2)",           desc = "Easymotion search" },
        { "S",                 "<Plug>(easymotion-overwin-f2)",   desc = "Easymotion search overwin" },

        { "<leader><leader>",  group = "Easymotion" },
        { "<leader><leader>f", "<Plug>(easymotion-bd-f)",         desc = "Find char on current line" },
        { "<leader><leader>w", "<Plug>(easymotion-bd-w)",         desc = "Skip word" },
        { "<leader><leader>e", "<Plug>(easymotion-bd-e)",         desc = "Skip word end" },
        { "<leader><leader>l", "<Plug>(easymotion-lineforward)",  desc = "End of line" },
        { "<leader><leader>h", "<Plug>(easymotion-linebackward)", desc = "Start of line" },
    }
end

return M
