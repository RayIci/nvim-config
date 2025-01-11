local map = require("utils").keymap
local add = require("which-key").add

-- Keep all the possible keymaps here
-------------------------------------

-- Disable space behaviour in normal and visual mode
map({ "n", "v" }, "<space>", "<nop>")

----------------------------------------------------------------------------------------
-- DEFAULT KEYMAPS
add({
    -- File save
    { "<c-s>",            "<cmd>w<cr>",                                                                        desc = "Save file" },
    { "<c-a>",            "<cmd>noautocmd w<cr>",                                                              desc = "Save without formatting" },

    -- Deletion
    { "x",                '"_x',                                                                               desc = "Delete single char (no buff save)" },

    -- Vertical scroll and center
    { "<c-d>",            "<c-d>zz",                                                                           desc = "Scroll down" },
    { "<c-u>",            "<c-u>zz",                                                                           desc = "Scroll up" },

    -- Find and center
    { "n",                "nzzzv",                                                                             desc = "Find next" },
    { "N",                "Nzzzv",                                                                             desc = "Find previous" },

    -- Windows management
    { "<leader>v",        "<c-w>v",                                                                            desc = "Split window vertically" },
    { "<leader>h",        "<c-w>s",                                                                            desc = "Split window hrizontally" },
    { "<leader>=",        "<c-w>=",                                                                            desc = "Split window reset Size" },

    -- Move between windows
    { "<c-h>",            "<cmd>wincmd h<cr>",                                                                 desc = "Move on left window" },
    { "<c-j>",            "<cmd>wincmd j<cr>",                                                                 desc = "Move on bottom window" },
    { "<c-k>",            "<cmd>wincmd k<cr>",                                                                 desc = "Move on up window" },
    { "<c-l>",            "<cmd>wincmd l<cr>",                                                                 desc = "Move on right window" },

    -- Move code line Up, Down
    { "J",                "<cmd>m .+1<cr>==",                                                                  desc = "Move line up" },
    { "K",                "<cmd>m .-2<cr>==",                                                                  desc = "Move line down" },
    { "J",                ":m '> +1<cr>gv=gv",                                                                 desc = "Move line up",                     mode = "v" },
    { "K",                ":m '< -2<cr>gv=gv",                                                                 desc = "Move line down",                   mode = "v" },

    -- Resize with arrows
    { "<Up>",             [[<cmd>horizontal resize +5<cr>]],                                                   desc = "Resize horizontal (-)" },
    { "<Down>",           [[<cmd>horizontal resize -5<cr>]],                                                   desc = "Resize horizontal (+)" },
    { "<Left>",           [[<cmd>vertical resize +2<cr>]],                                                     desc = "Resize vertical (+)" },
    { "<Right>",          [[<cmd>vertical resize -2<cr>]],                                                     desc = "Resize vertical (-)" },

    -- Buffers
    { "<leader>b",        group = "Buffers" },
    { "<tab>",            "<cmd>bnext<cr>",                                                                    desc = "Buffer next" },
    { "<s-tab>",          "<cmd>bprevious<cr>",                                                                desc = "Buffer previous" },
    { "<leader>bn",       "<cmd>enew<cr>",                                                                     desc = "New" },

    -- Tabs
    { "<leader>j",        group = "Tabs" },
    { "<leader>jn",       "<cmd>tabnew<cr>",                                                                   desc = "New" },
    { "<leader>j<Tab>",   "<cmd>tabn<cr>",                                                                     desc = "Next" },
    { "<leader>j<S-Tab>", "<cmd>tabp<cr>",                                                                     desc = "Previous" },
    { "<leader>js",       "<cmd>tab split<cr>",                                                                desc = "Split" },

    -- Close keys
    { "<leader>x",        group = "Close" },
    { "<leader>x",        "<cmd>Bdelete<cr>",                                                                  desc = "Buffer close" },
    { "<leader>X",        "<cmd>Bdelete!<cr>",                                                                 desc = "Buffer close force (no save)" },
    { "<leader>xa",       ":bufdo :bdelete<cr>",                                                               desc = "Buffer delete all" },
    { "<leader>xs",       "<cmd>close<CR>",                                                                    desc = "Split close" },
    { "<leader>xj",       "<cmd>tabclose<cr>",                                                                 desc = "Tab close" },

    -- Diagnostics navigation
    { "[d",               vim.diagnostic.goto_prev,                                                            desc = "Go to previous diagnostic message" },
    { "]d",               vim.diagnostic.goto_next,                                                            desc = "Go to next diagnostic message" },
    { "[e",               "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", desc = "Prev error diagnostic" },
    { "]e",               "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", desc = "Next error diagnostic" },
    { "[w",               "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>",  desc = "Prev warning diagnostic" },
    { "]w",               "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>",  desc = "Next warning diagnostic" },
    { "[i",               "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.INFO})<CR>",  desc = "Prev info diagnostic" },
    { "]i",               "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.INFO})<CR>",  desc = "Next info diagnostic" },
    { "[h",               "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.HINT})<CR>",  desc = "Prev hint diagnostic" },
    { "]h",               "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.HINT})<CR>",  desc = "Next hint diagnostic" },

    -- Diagnostics
    { "<leader>d",        group = "Diagnostics" },
    { "<leader>dw",       vim.diagnostic.open_float,                                                           desc = "Open floating message" },

    -- Stay in indent mode
    { "<",                "<gv",                                                                               desc = "Indent left" },
    { ">",                ">gv",                                                                               desc = "Indent right" },

    -- General options
    { "<leader>o",        group = "Options" },
    { "<leader>ow",       "<cmd>set wrap!<cr>",                                                                desc = "Toggle line wrap" },
})

----------------------------------------------------------------------------------------
-- NEOTREE KEYMAPS
add({
    { "<leader>e",  "<cmd>Neotree toggle position=right<cr>",      desc = "Toggle workspace tree" },

    { "<leader>bw", "<cmd>Neotree buffers position=float<cr>",     desc = "Window" },

    { "<leader>g",  group = "Git" },
    { "<leader>gs", "<cmd>Neotree git_status position=float <cr>", desc = "Git status" },
})

----------------------------------------------------------------------------------------
-- BUFFERLINE
add({
    { "<C-Left>",  "<cmd>BufferLineMovePrev<cr>", desc = "Buffer Move Previous" },
    { "<C-Right>", "<cmd>BufferLineMoveNext<cr>", desc = "Buffer Move Next" },
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
