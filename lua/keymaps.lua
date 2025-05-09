local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- Groups
mapgroup('<leader>g', 'Git')
mapgroup('<leader>b', 'Buffers')
mapgroup('<leader>l', 'LSP', { "v", "n" })
mapgroup('<leader>d', 'Debug')

-- Explorer
map("n", '<leader>e', mnvim.explorer.actions.open_explorer, { desc = 'Open explorer' })
map("n", '<leader>ge', mnvim.explorer.actions.open_git_explorer, { desc = 'Open git explorer' })
map("n", '<leader>be', mnvim.explorer.actions.open_buffer_explorer, { desc = 'Open buffer explorer' })

-- Formatting
map("n", "<leader>f", mnvim.code.formatters.actions.format, { desc = "Format file" })
map("x", "<leader>f", mnvim.code.formatters.actions.format_range, { desc = "Format selection" })

-- Diagnostics
map("n", "[d", mnvim.diagnostics.actions.prev_diagnostics, { desc = "Previous diagnostic" })
map("n", "]d", mnvim.diagnostics.actions.next_diagnostics, { desc = "Next diagnostic" })
map("n", "[e", mnvim.diagnostics.actions.prev_error, { desc = "Previous error" })
map("n", "]e", mnvim.diagnostics.actions.next_error, { desc = "Next error" })
map("n", "[w", mnvim.diagnostics.actions.prev_warning, { desc = "Previous warning" })
map("n", "]w", mnvim.diagnostics.actions.next_warning, { desc = "Next warning" })
map("n", "[i", mnvim.diagnostics.actions.prev_info, { desc = "Previous info" })
map("n", "]i", mnvim.diagnostics.actions.next_info, { desc = "Next info" })
map("n", "[h", mnvim.diagnostics.actions.prev_hint, { desc = "Previous hint" })
map("n", "]h", mnvim.diagnostics.actions.next_hint, { desc = "Next hint" })

--------------------------------------------------------------------------------------------
-- LSP (on attach)
--------------------------------------------------------------------------------------------
mnvim.code.lsp.add_on_attach_function(function (client, bufnr)
    local lsp = mnvim.code.lsp.actions
    map("n", "gD", lsp.declaration, { buffer = bufnr, desc = "Go declaration" })
    map("n", "gd", lsp.definition, { buffer = bufnr, desc = "Go definition" })
    map("n", "gI", lsp.implementation, { buffer = bufnr, desc = "Go implementation" })
    map("n", "gr", lsp.references, { buffer = bufnr, desc = "Go references" })
    map({ "n", "i" }, "<M-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    map({ "n", "v" }, "<leader>la", lsp.code_action, { desc = "Code action" })
    map("n", "<leader>lr", lsp.rename, { desc = "Rename" })
    map("n", "<leader>ll", lsp.code_lens, { buffer = bufnr, desc = "Code lense" })
    map("n", "H", lsp.hover, { buffer = bufnr, desc = "Hover" })
end)

--------------------------------------------------------------------------------------------
-- DAP keymaps
--------------------------------------------------------------------------------------------
local dap = mnvim.code.dap.actions
map("n", "<leader>dT", dap.virtual_text_toggle, { desc = "Toggle virtual text" })

map("n", "<c-b>", dap.breakpoint_toggle, { desc = "Breakpoint toggle" })
map("n", "<leader>db", dap.breakpoint_toggle, { desc = "Breakpoint toggle" })
map("n", "<leader>dl", dap.breakepoint_logpoint_add, { desc = "Breakepoint log" })
map("n", "<leader>dj", dap.breakpoint_conditional_add, { desc = "Breakepoint conditional" })
map("n", "<leader>xb", dap.breakpoints_clear, { desc = "Breakepoint clear all" })

map("n", "<leader>dr", dap.run_last, { desc = "Run last" })
map("n", "<leader>dp", dap.pause, { desc = "Pause" })
map("n", "<leader>dk", dap.terminate, { desc = "Terminate" })

map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<F5>", dap.continue, { desc = "Debugger: continue" })
map("n", "<F1>", dap.step_into, { desc = "Debugger: step into" })
map("n", "<F2>", dap.step_over, { desc = "Debugger: step over" })
map("n", "<F3>", dap.step_out, { desc = "Debugger: step out" })

map("n", "<leader>dR", dap.repl_toggle, { desc = "Repl toggle" })
