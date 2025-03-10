local map = require "utils.keymaps".map
local add = require "which-key".add

-- TROUBLE KEYMAPS
add {
    { "<leader>k",  group = "Trouble" },
    { "<leader>kw", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "All windows" },
    { "<leader>ks", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols list" },
    { "<leader>kl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
    { "<leader>kq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
    { "<leader>kd", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostic toggle" },
    { "<leader>kD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostic buffer toggle" },
}

-- LSP SAGA
add {
    -- Diagnostics navigation
    { "[d", "<cmd>Lspsaga diagnostic_jump_next<cr>",                                                              desc = "Go to next diagnostic message" },
    { "]d", "<cmd>Lspsaga diagnostic_jump_prev<cr>",                                                              desc = "Go to previous diagnostic message" },

    { "[e", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = "Next error diagnostic" },
    { "]e", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = "Prev error diagnostic" },

    { "[w", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.WARN })<CR>",  desc = "Next warning diagnostic" },
    { "]w", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.WARN })<CR>",  desc = "Prev warning diagnostic" },

    { "[i", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.INFO })<CR>",  desc = "Next info diagnostic" },
    { "]i", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.INFO })<CR>",  desc = "Prev info diagnostic" },

    { "[h", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.HINT })<CR>",  desc = "Next hint diagnostic" },
    { "]h", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.HINT })<CR>",  desc = "Prev hint diagnostic" },
}

-- UNDO TREE
add {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree toggle" },
}
