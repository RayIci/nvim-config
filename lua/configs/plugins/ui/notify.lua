local notify = require("notify")

-- Setup
notify.setup({
    stages = "fade_in_slide_out",
    timeout = 200,
    top_down = false,
    render = "default",
    max_width = 50,
    max_height = 10,
    background_colour = "#000000",
})

vim.notify = require("notify")

-- KEYMAPS
local map = require("utils.keymaps").map

require("which-key").add({
    { "<leader>n", group = "Notifications" },
})

map("n", "<leader>nf", "<cmd>Telescope notify<cr>", { desc = "Show notifications" })
map("n", "<leader>xk", notify.dismiss, { desc = "Kill/Dismiss notifications" })
map("n", "<leader>nh", notify.clear_history, { desc = "Clear history" })
