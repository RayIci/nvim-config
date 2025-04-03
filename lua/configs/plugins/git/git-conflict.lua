require("git-conflict").setup({
    default_mappings = false,
})

require("which-key").add({
    { "<leader>c", group = "Git conflict" },
})

local map = require("utils.keymaps").map
map("n", "<leader>cc", "<cmd>GitConflictChooseOurs<cr>", { desc = "Select the current changes" })
map("n", "<leader>ci", "<cmd>GitConflictChooseTheirs <cr>", { desc = "Select the incoming changes" })
map("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Select both changes" })
map("n", "<leader>cN", "<cmd>GitConflictChooseNone<cr>", { desc = "Select none of the changes" })
map("n", "<leader>c<tab>", "<cmd>GitConflictNextConflict<cr>", { desc = "Move to the next conflict" })
map("n", "<leader>c<S-tab>", "<cmd>GitConflictPrevConflict<cr>", { desc = "Move to the previous conflict" })
map("n", "<leader>cq", "<cmd>GitConflictListQf<cr>", { desc = "Get all conflict to quickfix" })
