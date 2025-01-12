local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Test language specific plugins
        "nvim-neotest/neotest-python",
    },
}

function M.adapters()
    return {
        require "neotest-python"
    }
end

function M.config()
    require("neotest").setup({
        adapters = M.adapters(),
        cache = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/neotest",
        },
    })
end

return M
