local map = require("utils.keymaps").map

require("which-key").add({
    { "<leader>f", group = "Find", mode = "v" },
})

map("n", "<leader>fs", "<cmd>lua require('spectre').toggle()<cr>", { desc = "Specter toggle" })
map("n", "<leader>fw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Specter search word" })
-- TODO: Should review since not working
-- map("v", "<leader>fw", "<esc><cmd>lua require('spectre').open_visual()<CR>", { desc = "Specter search selected word" })
map("n", "<leader>ff", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Specter search in file" })
