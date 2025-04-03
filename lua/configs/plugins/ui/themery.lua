local map = require("utils.keymaps").map
map("n", "<leader>ot", "<cmd>Huez<cr>", { desc = "Change theme" })

require("huez").setup({
    notify = true,
    persist = true,
})
