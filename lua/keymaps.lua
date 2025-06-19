local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- Groups
mapgroup("<leader>g", "Git")
mapgroup("<leader>c", "Git conflict")
mapgroup("<leader>b", "Buffers")
mapgroup("<leader>l", "LSP", { "v", "n" })
mapgroup("<leader>r", "Runner")
mapgroup("<leader>d", "Debug")
mapgroup("<leader>j", "Tabs")
mapgroup("<leader>x", "Close")
mapgroup("<leader>q", "Lists")
mapgroup("<leader>o", "Options")
mapgroup("<leader>ol", "Colorcolumn")
mapgroup("<leader>ob", "Background")
mapgroup("<leader>p", "Pickers")
mapgroup("<leader>t", "Terminal")
mapgroup("<leader>T", "Terminal")

-----------------------------------------------------------------------------------------

-- Formatting
map("n", "<leader>f", mnvim.code.formatters.actions.format, { desc = "Format file" })
map("x", "<leader>f", mnvim.code.formatters.actions.format_range, { desc = "Format selection" })

-- Disable space behaviour in normal and visual mode
map({ "n", "v" }, "<space>", "<nop>", {})

-- Keep last yanked when pasting
map("v", "p", '"_dP', { desc = "Paste" })

-- Center next and previous position
map("n", "<c-i>", "<c-i>zz", { desc = "Next position" })
map("n", "<c-o>", "<c-o>zz", { desc = "Prev position" })

-- Session
map("n", "<leader>s", mnvim.session.actions.select, { desc = "Session select" })

-- Remap ctrl+c to esc (used for copilot to clear virtual text when using ctrl+c)
map("i", "<c-c>", "<esc>", { desc = "Ctrl+c to esc" })

-- Remap to nothing alt+space (since idk why but if you press it default is exit insert)
map("i", "<a-space>", "<nop>", {})

-- File save and quit
map("n", "<c-s>", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<c-a>", "<cmd>noautocmd w<cr>", { desc = "Save without formatting" })
map("n", "<c-q>", "<cmd>q<cr>", { desc = "Quit" })

-- Deletion
map({ "n", "x", "v" }, "x", '"_x', { desc = "Delete single char (no buff save)" })

-- Vertical scroll and center
map("n", "<c-d>", "<c-d>zz", { desc = "Scroll down" })
map("n", "<c-u>", "<c-u>zz", { desc = "Scroll up" })

-- Find and center
map("n", "n", "nzzzv", { desc = "Find next" })
map("n", "N", "Nzzzv", { desc = "Find previous" })

-- Remove find
map("n", "<c-x>", "<cmd>noh<cr>", { desc = "Clear find" })

-- Windows management
map("n", "<leader>v", "<c-w>v", { desc = "Split window vertically" })
map("n", "<leader>h", "<c-w>s", { desc = "Split window hrizontally" })
map("n", "<leader>=", "<c-w>=", { desc = "Split window reset Size" })
map("n", "<leader>xs", "<cmd>close<CR>", { desc = "Split close" })

-- Move between windows
map("n", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Move on left window" })
map("n", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Move on bottom window" })
map("n", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Move on up window" })
map("n", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Move on right window" })

-- Move code line Up, Down
map("n", "J", "<cmd>m .+1<cr>==", { desc = "Move line up" })
map("n", "K", "<cmd>m .-2<cr>==", { desc = "Move line down" })
map("v", "J", ":m '> +1<cr>gv=gv", { desc = "Move line up" })
map("v", "K", ":m '< -2<cr>gv=gv", { desc = "Move line down" })

-- Resize with arrows
map("n", "<Up>", [[<cmd>horizontal resize +5<cr>]], { desc = "Resize horizontal (-)" })
map("n", "<Down>", [[<cmd>horizontal resize -5<cr>]], { desc = "Resize horizontal (+)" })
map("n", "<Left>", [[<cmd>vertical resize +2<cr>]], { desc = "Resize vertical (+)" })
map("n", "<Right>", [[<cmd>vertical resize -2<cr>]], { desc = "Resize vertical (-)" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Quickfix and loclist
map("n", "<leader>qq", "<cmd>Copen<cr>", { desc = "Quickfix open" })
map("n", "<leader>ql", "<cmd>Lopen<cr>", { desc = "Loclist open" })

-- General options
map("n", "<leader>ow", "<cmd>set wrap!<cr>", { desc = "Toggle line wrap" })
map("n", "<leader>oc", "<cmd>set cursorline!<cr>", { desc = "Toggle cursor line" })
map("n", "<leader>oL", "<cmd>set list!<cr>", { desc = "Toggle list" })
map("n", "<leader>ot", mnvim.themes.actions.select, { desc = "Theme select" })

map("n", "<leader>obd", '<cmd>lua vim.o.background = "dark"<cr>', { desc = "Dark" })
map("n", "<leader>obl", '<cmd>lua vim.o.background = "light"<cr>', { desc = "Light" })

map("n", "<leader>ole", "<cmd>lua vim.opt.colorcolumn = '100'<cr>", { desc = "Enable" })
map("n", "<leader>old", "<cmd>lua vim.opt.colorcolumn = ''<cr>", { desc = "Disable" })
map("n", "<leader>ot", "<cmd>:= vim.bo.filetype<cr>", { desc = "Buffer file Type" })

-- Tabs
map("n", "<leader>jn", "<cmd>tabnew<cr>", { desc = "New" })
map("n", "<leader><Tab>", "<cmd>tabn<cr>", { desc = "Tab next" })
map("n", "<leader><S-Tab>", "<cmd>tabp<cr>", { desc = "Tab previous" })
map("n", "<leader>js", "<cmd>tab split<cr>", { desc = "Split" })
map("n", "<leader>xj", "<cmd>tabclose<cr>", { desc = "Tab close" })

-----------------------------------------------------------------------------------------
--- PLUGINS KEYMAPS
-----------------------------------------------------------------------------------------

-- Explorer
map("n", "<leader>e", mnvim.explorer.actions.open_explorer, { desc = "Open explorer" })
map("n", "<leader>ge", mnvim.explorer.actions.open_git_explorer, { desc = "Open git explorer" })
map("n", "<leader>be", mnvim.explorer.actions.open_buffer_explorer, { desc = "Open buffer explorer" })

-- Buffers
map("n", "<leader>xw", mnvim.buffers.actions.close, { desc = "Buffer close" })
map("n", "<leader>xf", mnvim.buffers.actions.close_force, { desc = "Buffer close force (no save)" })
map("n", "<leader>xa", mnvim.buffers.actions.close_all, { desc = "Buffer close all" })
map("n", "<leader>xA", mnvim.buffers.actions.close_all_but_this_one, { desc = "Buffer close all but this one" })
map("n", "<leader>bn", mnvim.buffers.actions.new, { desc = "New" })
map("n", "<c-left>", mnvim.buffers.actions.move_previous, { desc = "Buffer move previous" })
map("n", "<c-right>", mnvim.buffers.actions.move_next, { desc = "Buffer move next" })
map("n", "<leader>bp", mnvim.buffers.actions.pin_toggle, { desc = "Pin toggle" })
map("n", "<tab>", mnvim.buffers.actions.next, { desc = "Buffer next" })
map("n", "<s-tab>", mnvim.buffers.actions.previous, { desc = "Buffer previous" })
map("n", "<leader>bs", mnvim.buffers.actions.scratch, { desc = "Scratch buffer" })
map("n", "<leader>bS", mnvim.telescope.actions.pick_scratch_buffer, { desc = "Pick scratch buffer" })

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
mnvim.code.lsp.add_on_attach_function(function(_, bufnr)
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

map("n", "<leader>de", dap.evaluate, { desc = "UI reset" })

map("n", "<leader>dR", dap.repl_ui_toggle, { desc = "Repl toggle" })
map("n", "<leader>dC", dap.console_ui_toggle, { desc = "Console toggle" })
map("n", "<leader>ds", dap.scopes_ui_toggle, { desc = "Scopes toggle" })
map("n", "<leader>dS", dap.stacks_ui_toggle, { desc = "Stacks toggle" })
map("n", "<leader>dB", dap.breakpoints_ui_toggle, { desc = "Breakpoints toggle" })
map("n", "<leader>dW", dap.watches_ui_toggle, { desc = "Watches toggle" })
map("n", "<leader>dt", dap.ui_toggle, { desc = "UI toggle" })
map("n", "<leader>dp", dap.ui_reset, { desc = "UI reset" })

--------------------------------------------------------------------------------------------
-- Pickers
--------------------------------------------------------------------------------------------
map("n", "<leader><leader>", mnvim.telescope.actions.pick_file, { desc = "Pick file" })
map("n", "<leader>pg", mnvim.telescope.actions.grep_files, { desc = "Grep files" })
map("n", "<leader>pp", mnvim.telescope.actions.pick_resume, { desc = "Pick resume" })
map("n", "<leader>pb", mnvim.telescope.actions.pick_buffer, { desc = "Pick buffer" })
map("n", "<leader>ph", mnvim.telescope.actions.pick_help_tag, { desc = "Pick helper tag" })
map("n", "<leader>pn", mnvim.telescope.actions.pick_notification, { desc = "Pick notification" })
map("n", "<leader>pm", mnvim.telescope.actions.pick_mark, { desc = "Pick mark" })
map("n", "<leader>pt", mnvim.comments.actions.pick_todo, { desc = "Pick todo" })
map("n", "<leader>pk", mnvim.telescope.actions.pick_keymap, { desc = "Pick keymap" })
map("n", "<leader>pT", mnvim.telescope.actions.pick_terminal, { desc = "Pick terminal" })

--------------------------------------------------------------------------------------------
-- Git
--------------------------------------------------------------------------------------------
map("n", "<leader>gl", mnvim.git.actions.lazygit_open, { desc = "Lazygit" })
map("n", "<leader>gb", mnvim.git.actions.branch_select, { desc = "Branch select" })

map("n", "<leader>gd", mnvim.git.diffview.actions.open, { desc = "Diffview open" })
map("n", "<leader>gD", mnvim.git.diffview.actions.close, { desc = "Diffview close" })
map("n", "<leader>gr", mnvim.git.diffview.actions.refresh, { desc = "Diffview refresh" })
map("n", "<leader>gf", mnvim.git.diffview.actions.history_files, { desc = "Diffview files history" })
map("n", "<leader>gF", mnvim.git.diffview.actions.history_current_file, { desc = "Diffview current file history" })
map("n", "<leader>gt", mnvim.git.diffview.actions.files_toggle, { desc = "Diffview toggle files" })
map("n", "<leader>gT", mnvim.git.diffview.actions.current_file_toggle, { desc = "Diffview toggle current file" })

map("n", "<leader>cc", mnvim.git.conflicts.actions.select_current, { desc = "Select the current changes" })
map("n", "<leader>ci", mnvim.git.conflicts.actions.select_incoming, { desc = "Select the incoming changes" })
map("n", "<leader>cb", mnvim.git.conflicts.actions.select_both, { desc = "Select both changes" })
map("n", "<leader>cN", mnvim.git.conflicts.actions.select_none, { desc = "Select none of the changes" })
map("n", "]c", mnvim.git.conflicts.actions.next_conflict, { desc = "Move to the next conflict" })
map("n", "[c", mnvim.git.conflicts.actions.prev_conflict, { desc = "Move to the previous conflict" })
map("n", "<leader>cq", mnvim.git.conflicts.actions.quickfix, { desc = "Get all conflict to quickfix" })

--------------------------------------------------------------------------------------------
-- Todo Comments
--------------------------------------------------------------------------------------------
map("n", "]t", mnvim.comments.actions.next_todo, { desc = "Next todo" })
map("n", "[t", mnvim.comments.actions.prev_todo, { desc = "Prev todo" })

--------------------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------------------
map("n", "<leader>Tf", mnvim.terminal.actions.new_floating, { desc = "Floating" })
map("n", "<leader>Th", mnvim.terminal.actions.new_horizontal, { desc = "Horizontal" })
map("n", "<leader>Tv", mnvim.terminal.actions.new_vertical, { desc = "Vertical" })

--------------------------------------------------------------------------------------------
--- Test keymaps
--------------------------------------------------------------------------------------------
map("n", "<leader>tt", mnvim.code.test.actions.run, { desc = "Run nearest" })
map("n", "<leader>tl", mnvim.code.test.actions.run_last, { desc = "Run last" })
map("n", "<leader>tr", mnvim.code.test.actions.run_file, { desc = "Run file" })
map("n", "<leader>tT", mnvim.code.test.actions.run_file, { desc = "Run all" })
map("n", "<leader>td", mnvim.code.test.actions.run_debugging, { desc = "Run debugging" })

map("n", "<leader>tk", mnvim.code.test.actions.stop, { desc = "Stop" })
map("n", "<leader>tA", mnvim.code.test.actions.attach, { desc = "Attach" })

map("n", "<leader>tw", mnvim.code.test.actions.watch_toggle, { desc = "Watch toggle" })
map("n", "<leader>tW", mnvim.code.test.actions.watch_toggle_file, { desc = "Watch toggle file" })

map("n", "<leader>tO", mnvim.code.test.actions.output_open, { desc = "Output open" })
map("n", "<leader>xo", mnvim.code.test.actions.output_close, { desc = "Test output close" })
map("n", "<leader>to", mnvim.code.test.actions.output_panel_toggle, { desc = "Output panel toggle" })

map("n", "<leader>ts", mnvim.code.test.actions.summary_toggle, { desc = "Summary toggle" })

--------------------------------------------------------------------------------------------
--- Runner
--------------------------------------------------------------------------------------------
map("n", "<leader>rr", mnvim.code.runner.actions.run, { desc = "Run" })
map("n", "<leader>ru", mnvim.code.runner.actions.ui_toggle, { desc = "Toggle ui" })

--------------------------------------------------------------------------------------------
--- Autocmd keymaps
--------------------------------------------------------------------------------------------
--- Make possible to close the quickfix window with q
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf", -- qf = quickfix
    callback = function()
        map("n", "q", "<cmd>close<cr>", { buffer = true })
    end,
})
