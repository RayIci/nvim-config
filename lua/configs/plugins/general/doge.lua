vim.g.doge_enable_mappings = 1
vim.g.doge_comment_type = "auto"
vim.g.doge_doc_standard_python = "reST"

local map = require("utils.keymaps").map
map("n", "<leader>G", "<Plug>(doge-generate)", { desc = "Docstring Generate" })
