require("diffview").setup({})

require("which-key").add({
    { "<leader>g", group = "Git" },
})

local map = require("utils.keymaps").map
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" })
map("n", "<leader>gf", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview File History" })
map("n", "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview File History Current File" })
map("n", "<leader>gr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview Refresh" })
map("n", "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview Toggle Files" })
map("n", "<leader>gT", "<cmd>DiffviewToggleFiles %<cr>", { desc = "Diffview Toggle Files Current File" })
