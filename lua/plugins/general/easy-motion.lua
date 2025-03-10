local M = {
    "easymotion/vim-easymotion"
}

function M.config()
    vim.g.EasyMotion_do_mapping = 0
    M.keymaps()
end

function M.keymaps()
    require "which-key".add {

        { "<leader>w",  group = "Easymotion" },
        { "<leader>ws", "<Plug>(easymotion-s2)",           desc = "Easymotion search" },
        { "<leader>wS", "<Plug>(easymotion-overwin-f2)",   desc = "Easymotion search overwin" },
        { "<leader>wf", "<Plug>(easymotion-bd-f)",         desc = "Find char on current line" },
        { "<leader>ww", "<Plug>(easymotion-bd-w)",         desc = "Skip word" },
        { "<leader>we", "<Plug>(easymotion-bd-e)",         desc = "Skip word end" },
        { "<leader>wl", "<Plug>(easymotion-lineforward)",  desc = "End of line" },
        { "<leader>wh", "<Plug>(easymotion-linebackward)", desc = "Start of line" },
    }
end

return M
