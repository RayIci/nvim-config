local map = require("utils").keymap
local add = require("which-key").add

-- Keep all the possible keymaps here
-------------------------------------

-- Disable space behaviour in normal and visual mode
map({ "n", "v" }, "<space>", "<nop>")

-- Keep last yanked when pasting
map("v", "p", '"_dP', { desc = "Paste" })

-- Center next and previous position
map("n", "<c-o>", "<c-o>zz", { desc = "Prev position" })
map("n", "<c-i>", "<c-i>zz", { desc = "Next position" })

-- Remap ctrl+c to esc
map("i", "<c-c>", "<esc>", { desc = "Ctrl+c to esc" })

-- Remap to nothing alt+space since idk why but if you press it default is exit insert
map("i", "<a-space>", "<nop>")

----------------------------------------------------------------------------------------
-- DEFAULT KEYMAPS
add({
    -- File save
    { "<c-s>",           "<cmd>w<cr>",                                                                        desc = "Save file" },
    { "<c-a>",           "<cmd>noautocmd w<cr>",                                                              desc = "Save without formatting" },

    -- Deletion
    { "x",               '"_x',                                                                               desc = "Delete single char (no buff save)" },

    -- Vertical scroll and center
    { "<c-d>",           "<c-d>zz",                                                                           desc = "Scroll down" },
    { "<c-u>",           "<c-u>zz",                                                                           desc = "Scroll up" },

    -- Find and center
    { "n",               "nzzzv",                                                                             desc = "Find next" },
    { "N",               "Nzzzv",                                                                             desc = "Find previous" },

    -- Remove find
    { "<c-x>",           "<cmd>noh<cr>",                                                                      desc = "Clear find" },

    -- Windows management
    { "<leader>v",       "<c-w>v",                                                                            desc = "Split window vertically" },
    { "<leader>h",       "<c-w>s",                                                                            desc = "Split window hrizontally" },
    { "<leader>=",       "<c-w>=",                                                                            desc = "Split window reset Size" },

    -- Move between windows
    { "<c-h>",           "<cmd>wincmd h<cr>",                                                                 desc = "Move on left window" },
    { "<c-j>",           "<cmd>wincmd j<cr>",                                                                 desc = "Move on bottom window" },
    { "<c-k>",           "<cmd>wincmd k<cr>",                                                                 desc = "Move on up window" },
    { "<c-l>",           "<cmd>wincmd l<cr>",                                                                 desc = "Move on right window" },

    -- Move code line Up, Down
    { "J",               "<cmd>m .+1<cr>==",                                                                  desc = "Move line up" },
    { "K",               "<cmd>m .-2<cr>==",                                                                  desc = "Move line down" },
    { "J",               ":m '> +1<cr>gv=gv",                                                                 desc = "Move line up",                     mode = "v" },
    { "K",               ":m '< -2<cr>gv=gv",                                                                 desc = "Move line down",                   mode = "v" },

    -- Resize with arrows
    { "<Up>",            [[<cmd>horizontal resize +5<cr>]],                                                   desc = "Resize horizontal (-)" },
    { "<Down>",          [[<cmd>horizontal resize -5<cr>]],                                                   desc = "Resize horizontal (+)" },
    { "<Left>",          [[<cmd>vertical resize +2<cr>]],                                                     desc = "Resize vertical (+)" },
    { "<Right>",         [[<cmd>vertical resize -2<cr>]],                                                     desc = "Resize vertical (-)" },

    -- Buffers
    { "<leader>b",       group = "Buffers" },
    { "<leader>bn",      "<cmd>enew<cr>",                                                                     desc = "New" },

    -- Tabs
    { "<leader>j",       group = "Tabs" },
    { "<leader>jn",      "<cmd>tabnew<cr>",                                                                   desc = "New" },
    { "<leader><Tab>",   "<cmd>tabn<cr>",                                                                     desc = "Next" },
    { "<leader><S-Tab>", "<cmd>tabp<cr>",                                                                     desc = "Previous" },
    { "<leader>js",      "<cmd>tab split<cr>",                                                                desc = "Split" },

    -- Close keys
    { "<leader>x",       group = "Close" },
    { "<leader>xw",      ":Bdelete<cr>",                                                                      desc = "Buffer close" },
    { "<leader>xf",      ":Bdelete!<cr>",                                                                     desc = "Buffer close force (no save)" },
    { "<leader>xa",      ":bufdo :Bdelete<cr>",                                                               desc = "Buffer close all" },
    { "<leader>xs",      "<cmd>close<CR>",                                                                    desc = "Split close" },
    { "<leader>xj",      "<cmd>tabclose<cr>",                                                                 desc = "Tab close" },

    -- Diagnostics navigation
    { "[d",              vim.diagnostic.goto_prev,                                                            desc = "Go to previous diagnostic message" },
    { "]d",              vim.diagnostic.goto_next,                                                            desc = "Go to next diagnostic message" },
    { "[e",              "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", desc = "Prev error diagnostic" },
    { "]e",              "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", desc = "Next error diagnostic" },
    { "[w",              "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>",  desc = "Prev warning diagnostic" },
    { "]w",              "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>",  desc = "Next warning diagnostic" },
    { "[i",              "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.INFO})<CR>",  desc = "Prev info diagnostic" },
    { "]i",              "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.INFO})<CR>",  desc = "Next info diagnostic" },
    { "[h",              "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.HINT})<CR>",  desc = "Prev hint diagnostic" },
    { "]h",              "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.HINT})<CR>",  desc = "Next hint diagnostic" },

    -- Diagnostics
    { "<leader>D",       group = "Diagnostics" },
    { "<leader>Dw",      vim.diagnostic.open_float,                                                           desc = "Open floating message" },

    -- Stay in indent mode
    { "<",               "<gv",                                                                               desc = "Indent left",                      mode = "v" },
    { ">",               ">gv",                                                                               desc = "Indent right",                     mode = "v" },

    -- General options
    { "<leader>o",       group = "Options" },
    { "<leader>ow",      "<cmd>set wrap!<cr>",                                                                desc = "Toggle line wrap" },
    { "<leader>ob",      require "utils".toggle_nvim_background,                                              desc = "Toggle neovim background" },
})

----------------------------------------------------------------------------------------
-- NEOTREE KEYMAPS
add({
    { "<leader>e",  "<cmd>Neotree toggle<cr>",                     desc = "Toggle workspace tree" },

    { "<leader>bw", "<cmd>Neotree buffers position=float<cr>",     desc = "Window" },

    { "<leader>g",  group = "Git" },
    { "<leader>gs", "<cmd>Neotree git_status position=float <cr>", desc = "Git status" },
})

----------------------------------------------------------------------------------------
-- BUFFERLINE KEYMAPS
add({
    { "<leader>xA", "<cmd>%bd|e#|bd#<cr>",          desc = "Close all but this one" },
    { "<C-Left>",   "<cmd>BufferLineMovePrev<cr>",  desc = "Buffer Move Previous" },
    { "<C-Right>",  "<cmd>BufferLineMoveNext<cr>",  desc = "Buffer Move Next" },
    { "<leader>bp", "<cmd>BufferTogglePin<cr>",     desc = "Pin Toggle" },
    { "<tab>",      "<cmd>BufferLineCycleNext<cr>", desc = "Buffer next" },
    { "<s-tab>",    "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer previous" },
})

----------------------------------------------------------------------------------------
-- LSP KEYMAPS
add({
    -- Formatting
    { "<leader>f",  "<cmd>lua vim.lsp.buf.format({async = true})<cr>",       desc = "Format file" },
    { "<leader>f",  "<cmd>'<'>lua vim.lsp.buf.format({async = true})<CR>",   desc = "Format selection", mode = { "v" } },

    { "<leader>l",  group = "LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                desc = "Code Action" },
    { "<leader>li", "<cmd>LspInfo<cr>",                                      desc = "Info" },
    { "<leader>lh", "<cmd>lua require('code.lsp').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",                   desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",              desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                     desc = "Rename" },

    { "<leader>l",  group = "LSP",                                           mode = "v" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                desc = "Code Action",      mode = { "v" }, },
})


----------------------------------------------------------------------------------------
-- ILLUMINATE KEYMAPS
add({
    { "<C-g>", require("illuminate").goto_next_reference, desc = "Prossima referenza" },
    { "<C-p>", require("illuminate").goto_prev_reference, desc = "Referenza precedente" },
})


----------------------------------------------------------------------------------------
-- TELESCOPE KEYMAPS
add({
    { "<leader><leader>", "<cmd>Telescope find_files<cr>",                             desc = "Find File" },

    { "<leader>f",        group = "Find" },
    { "<leader>fg",       require 'telescope'.extensions.live_grep_args.live_grep_args, desc = "Live Grep" },
    { "<leader>fb",       "<cmd>Telescope buffers<cr>",                                desc = "Buffers" },
    { "<leader>fh",       "<cmd>Telescope help_tags<cr>",                              desc = "Help Tags" },
    { "<leader>fn",       "<cmd>Telescope notify<cr>",                                 desc = "Notifications" },
    { "<leader>fm",       "<cmd>Telescope marks<cr>",                                  desc = "Marks" },
    { "<leader>ft",       "<cmd>TodoTelescope<cr>",                                    desc = "Todos" }
})


----------------------------------------------------------------------------------------
-- NOTIFY KEYMAPS
add({
    { "<leader>n",  group = "Notifications" },
    { "<leader>nf", "<cmd>Telescope notify<cr>",     desc = "Show notifications" },
    { "<leader>xk", require("notify").dismiss,       desc = "Kill/Dismiss notifications" },
    { "<leader>nh", require("notify").clear_history, desc = "Clear history" },
})


----------------------------------------------------------------------------------------
-- UNDOTREE KEYMAPS
add({
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree toggle" },
})


----------------------------------------------------------------------------------------
-- DODGE KEYMAPS
add({
    { "<leader>G", "<Plug>(doge-generate)", desc = "Docstring Generate" },
})


----------------------------------------------------------------------------------------
-- TROUBLE KEYMAPS
add({
    { "<leader>k",  group = "Trouble" },
    { "<leader>kw", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "All windows" },
    { "<leader>ks", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols list" },
    { "<leader>kl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
    { "<leader>kq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
    { "<leader>kd", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostic toggle" },
    { "<leader>kD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostic buffer toggle" },
})


----------------------------------------------------------------------------------------
-- GIT KEYMAPS
add({
    { "<leader>g",        group = "Git" },
    { "<leader>gd",       "<cmd>DiffviewOpen<cr>",             desc = "Diffview" },
    { "<leader>gD",       "<cmd>DiffviewClose<cr>",            desc = "Diffview Close" },
    { "<leader>gf",       "<cmd>DiffviewFileHistory<cr>",      desc = "Diffview File History" },
    { "<leader>gF",       "<cmd>DiffviewFileHistory %<cr>",    desc = "Diffview File History Current File" },
    { "<leader>gr",       "<cmd>DiffviewRefresh<cr>",          desc = "Diffview Refresh" },
    { "<leader>gt",       "<cmd>DiffviewToggleFiles<cr>",      desc = "Diffview Toggle Files" },
    { "<leader>gT",       "<cmd>DiffviewToggleFiles %<cr>",    desc = "Diffview Toggle Files Current File" },
    { "<leader>gl",       "<cmd>LazyGit<cr>",                  desc = "Open lazy git" },

    { "<leader>c",        group = "Git conflict" },
    { "<leader>cc",       "<cmd>GitConflictChooseOurs<cr>",    desc = "Select the current changes" },
    { "<leader>ci",       "<cmd>GitConflictChooseTheirs <cr>", desc = "Select the incoming changes" },
    { "<leader>cb",       "<cmd>GitConflictChooseBoth<cr>",    desc = "Select both changes" },
    { "<leader>cN",       "<cmd>GitConflictChooseNone<cr>",    desc = "Select none of the changes" },
    { "<leader>c<tab>",   "<cmd>GitConflictNextConflict<cr>",  desc = "Move to the next conflict" },
    { "<leader>c<S-tab>", "<cmd>GitConflictPrevConflict<cr>",  desc = "Move to the previous conflict" },
    { "<leader>cq",       "<cmd>GitConflictListQf<cr>",        desc = "Get all conflict to quickfix" },
})

----------------------------------------------------------------------------------------
-- DEBUGGER KEYMAPS
add({
    { "<leader>d",  group = "Debugger" },
    { "<leader>db", "<cmd>PBToggleBreakpoint<cr>",         desc = "Breakpoint toggle" },
    { "<leader>dl", "<cmd>PBSetLogPoint<cr>",              desc = "Brakepoint log" },
    { "<leader>dj", "<cmd>PBSetConditionalBreakpoint<cr>", desc = "Brakepoint conditional" },
    { "<leader>xb", "<cmd>PBClearAllBreakpoints<cr>",      desc = "Brakepoint clear all" },
    { "<leader>dn", require('goto-breakpoints').next,      desc = "Brakepoint next" },
    { "<leader>dN", require('goto-breakpoints').prev,      desc = "Brakepoint prev" },
    { "<leader>dy", require('goto-breakpoints').stopped,   desc = "Brakepoint stopped" },
    {
        "<leader>dc",
        function()
            require "dap.ext.vscode".json_decode = vim.fn.json_decode
            require "dap.ext.vscode".load_launchjs(".vscode/launch.json", nil)
            require "dap".continue()
        end,
        desc = "Continue",
    },
    { "<leader>dr", "<cmd>lua require('dap').run()<cr>",                            desc = "Run" },
    { "<leader>dp", "<cmd>lua require('dap').pause()<cr>",                          desc = "Pause" },
    { "<leader>dk", "<cmd>lua require('dap').terminate()<cr>",                      desc = "Kill" },

    { "<leader>dT", "<cmd>lua require('nvim-dap-virtual-text').toggle()<cr>",       desc = "Toggle Virtual Text" },

    { "<leader>ds", "<cmd>lua require('code.dapui').open_float('scopes')<cr>",      desc = "Floating Scopes" },
    { "<leader>dS", "<cmd>lua require('code.dapui').open_float('stacks')<cr>",      desc = "Floating Stacks" },
    { "<leader>dw", "<cmd>lua require('code.dapui').open_float('watches')<cr>",     desc = "Floating Watches" },
    { "<leader>dB", "<cmd>lua require('code.dapui').open_float('breakpoints')<cr>", desc = "Floating Breakpoint" },
    { "<leader>dE", "<cmd>lua require('code.dapui').open_float('repl')<cr>",        desc = "Floating Repl" },
    { "<leader>dC", "<cmd>lua require('code.dapui').open_float('console')<cr>",     desc = "Floating Console" },
    { "<leader>do", require "code.dapui".toggle_floating_config,                    desc = "Toggle floating config" },
    { "<leader>de", "<cmd>lua require('dapui').eval()<cr>",                         desc = "Floating Evaluate" },

    { "<F5>",       require "dap".continue,                                         desc = "Debugger: continue" },
    { "<F1>",       require "dap".step_into,                                        desc = "Debugger: step into" },
    { "<F2>",       require "dap".step_over,                                        desc = "Debugger: step over" },
    { "<F3>",       require "dap".step_out,                                         desc = "Debugger: step out" },

    -- UI keymaps
    { "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>",                       desc = "Toggle Ui" },
    { "<leader>dR", "<cmd>lua require('dapui').open({ reset = true })<cr>",         desc = "Reset Ui" },
})

----------------------------------------------------------------------------------------
-- UNIT TEST KEYMAPS
add({
    { "<leader>t",  group = "Test" },
    { "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>",                   desc = "Run" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run File" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    { "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>",                  desc = "Stop" },
    { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>",                desc = "Attach" },
    {
        "<leader>tw",
        "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>",
        desc = "Watch File Toggle",
    },
    { "<leader>to", "<cmd>lua require('neotest').output.open()<cr>",         desc = "Output Open" },
    { "<leader>tc", "<cmd>lua require('neotest').output.close()<cr>",        desc = "Output Close" },
    { "<leader>tO", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Output Panel Toggle" },
    { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>",      desc = "Summary Toggle" },
})


----------------------------------------------------------------------------------------
-- ZEN MODE KEYMAPS
add({
    { "<c-z>", "<cmd>ZenMode<cr>", desc = "Zen mode" }
})


----------------------------------------------------------------------------------------
-- AUTO SESSIONS KEYMAPS
add({
    { "<leader>s", require "auto-session.session-lens".search_session, desc = "Search sessions" }
})


----------------------------------------------------------------------------------------
-- GITHUB COPILOT KEYMAPS
map("i", "<c-t>", 'copilot#Accept("\\<CR>")', { desc = "Copilot accept", expr = true, replace_keycodes = false })
map("i", "<c-y>", '<plug>(copilot-accept-word)', { desc = "Copilot accept word" })
vim.g.copilot_no_tab_map = true
