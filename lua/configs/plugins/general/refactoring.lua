local map = require("utils.keymaps").map

require("refactoring").setup({})

require("which-key").add({
    { "<leader>r", group = "Refactoring" },
})

map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")

map("x", "<leader>rv", ":Refactor extract_var ")

map({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

map("n", "<leader>rI", ":Refactor inline_func")

map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")

map("n", "<leader>rp", function()
    require("refactoring").debug.printf({ below = false })
end, { desc = "Debug printf" })

map({ "x", "n" }, "<leader>rv", function()
    require("refactoring").debug.print_var()
end, { desc = "Debug print var" })
-- Supports both visual and normal mode

map("n", "<leader>rc", function()
    require("refactoring").debug.cleanup({})
end, { desc = "Debug clear debug" })
