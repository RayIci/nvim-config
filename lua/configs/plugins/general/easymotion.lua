require("which-key").add({
    { "<leader>w", group = "Easymotion" },
})

local map = require("utils.keymaps").map
map("n", "<leader>ws", "<Plug>(easymotion-s2)", { desc = "Easymotion search" })
map("n", "<leader>wS", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion search overwin" })
map("n", "<leader>wf", "<Plug>(easymotion-bd-f)", { desc = "Find char on current line" })
map("n", "<leader>ww", "<Plug>(easymotion-bd-w)", { desc = "Skip word" })
map("n", "<leader>we", "<Plug>(easymotion-bd-e)", { desc = "Skip word end" })
map("n", "<leader>wl", "<Plug>(easymotion-lineforward)", { desc = "End of line" })
map("n", "<leader>wh", "<Plug>(easymotion-linebackward)", { desc = "Start of line" })
