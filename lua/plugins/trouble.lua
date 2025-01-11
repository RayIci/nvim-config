-- Trouble is a plugin that makes it easy to see and navigate diagnostics, references, and other errors in a buffer.
-- https://github.com/folke/trouble.nvim

local keymaps = function()
    require("which-key").add({
        { "<leader>dd",  group = "Diagnostics" },
        { "<leader>ddw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Window (diagnostic) Toggle" },
        {
            "<leader>ddb",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Window (diagnostic) Buffer Toggle",
        },
    })
end

return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    config = function()
        require("trouble").setup({})
        keymaps()
    end,
}
