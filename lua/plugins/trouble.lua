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

return M
