local M = {
    'akinsho/git-conflict.nvim',
    version = "*"
}

function M.config()
    require "git-conflict".setup {
        default_mappings = false
    }

    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
        { "<leader>c",        group = "Git conflict" },
        { "<leader>cc",       "<cmd>GitConflictChooseOurs<cr>",    desc = "Select the current changes" },
        { "<leader>ci",       "<cmd>GitConflictChooseTheirs <cr>", desc = "Select the incoming changes" },
        { "<leader>cb",       "<cmd>GitConflictChooseBoth<cr>",    desc = "Select both changes" },
        { "<leader>cN",       "<cmd>GitConflictChooseNone<cr>",    desc = "Select none of the changes" },
        { "<leader>c<tab>",   "<cmd>GitConflictNextConflict<cr>",  desc = "Move to the next conflict" },
        { "<leader>c<S-tab>", "<cmd>GitConflictPrevConflict<cr>",  desc = "Move to the previous conflict" },
        { "<leader>cq",       "<cmd>GitConflictListQf<cr>",        desc = "Get all conflict to quickfix" },
    }
end

return M
