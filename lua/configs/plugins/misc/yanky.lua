require("yanky").setup({})

local map = require("utils.keymaps").map
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Paste after" })
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Paste before" })
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Paste g after" })
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Paste g before" })

map("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "Cycle previous yank" })
map("n", "<c-y>", "<Plug>(YankyNextEntry)", { desc = "Cycle next yank" })

map({ "n", "x" }, "<leader>p", Snacks.picker.yanky, { desc = "Yank select" })
