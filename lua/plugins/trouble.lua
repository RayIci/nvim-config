-- Trouble is a plugin that makes it easy to see and navigate diagnostics, references, and other errors in a buffer.
-- https://github.com/folke/trouble.nvim

local M = {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
}

function M.config()
    require("trouble").setup({
        height = 60,
        width = 60,
    })
end

return M
