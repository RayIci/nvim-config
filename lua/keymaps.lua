local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- Groups
mapgroup('<leader>g', 'Git')
mapgroup('<leader>b', 'Buffers')

-- Explorer
map("n", '<leader>e', mnvim.explorer.actions.open_explorer, { desc = 'Open Explorer' })
map("n", '<leader>ge', mnvim.explorer.actions.open_git_explorer, { desc = 'Open Git Explorer' })
map("n", '<leader>be', mnvim.explorer.actions.open_buffer_explorer, { desc = 'Open Buffer Explorer' })

-- Formatting
map("n", "<leader>f", mnvim.code.formatters.actions.format, { desc = "Format file" })
map("x", "<leader>f", mnvim.code.formatters.actions.format_range, { desc = "Format selection" })

-- LSP (on attach)
mnvim.code.lsp.add_on_attach_function(function (client, bufnr)
    map("n", "gD", mnvim.code.lsp.actions.declaration, { buffer = bufnr, desc = "Go declaration" })
    map("n", "gd", mnvim.code.lsp.actions.definition, { buffer = bufnr, desc = "Go definition" })
    map("n", "gI", mnvim.code.lsp.actions.implementation, { buffer = bufnr, desc = "Go implementation" })
    map("n", "gr", mnvim.code.lsp.actions.references, { buffer = bufnr, desc = "Go references" })
    map({ "n", "i" }, "<M-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature help" })

    require("which-key").add({
        { "<leader>l", group = "LSP" },
        { "<leader>l", group = "LSP", mode = "v" },
    })
    map({ "n", "v" }, "<leader>la", mnvim.code.lsp.actions.code_action, { desc = "Code action" })
    map("n", "<leader>lr", mnvim.code.lsp.actions.rename, { desc = "Rename" })
    map("n", "<leader>ll", mnvim.code.lsp.actions.code_lens, { buffer = bufnr, desc = "Code lense" })

    map("n", "H", mnvim.code.lsp.actions.hover, { buffer = bufnr, desc = "Hover" })
end)
