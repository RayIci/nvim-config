-- Trouble is a plugin that makes it easy to see and navigate diagnostics, references, and other errors in a buffer.
-- https://github.com/folke/trouble.nvim

local M = {
    "folke/trouble.nvim",
    opts = {
        modes = {
            symbols = {
                win = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.4,
                },
            },
        },
    },
    cmd = "Trouble",
}

function M.keymaps()
    require "which-key".add {
        { "<leader>k",  group = "Trouble" },
        { "<leader>kw", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "All windows" },
        { "<leader>ks", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols list" },
        { "<leader>kl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
        { "<leader>kq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
        { "<leader>kd", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostic toggle" },
        { "<leader>kD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostic buffer toggle" },
    }
end

return M
