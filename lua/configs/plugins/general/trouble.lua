require("which-key").add({
    { "<leader>k", group = "Trouble" },
})

local map = require("utils.keymaps").map
map("n", "<leader>kw", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "All windows" })
map("n", "<leader>ks", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols list" })
map("n", "<leader>kl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
map("n", "<leader>kq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })
map("n", "<leader>kd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostic toggle" })
map("n", "<leader>kD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostic buffer toggle" })
