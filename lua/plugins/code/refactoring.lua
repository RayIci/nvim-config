local M = {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
}

function M.config()
    require('refactoring').setup({})

    require("telescope").load_extension("refactoring")

    require "which-key".add {
        { "<leader>r", group = "Refactoring" }
    }

    vim.keymap.set(
        { "n", "x" },
        "<leader>rr",
        function() require('telescope').extensions.refactoring.refactors() end,
        { desc = "Select" }
    )

    vim.keymap.set(
        "n",
        "<leader>rp",
        function() require('refactoring').debug.printf({ below = false }) end,
        { desc = "Debug printf" }
    )

    vim.keymap.set({ "x", "n" }, "<leader>rv", function() require('refactoring').debug.print_var() end,
        { desc = "Debug print var" })
    -- Supports both visual and normal mode

    vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end,
        { desc = "Debug clear debug" })
end

return M
