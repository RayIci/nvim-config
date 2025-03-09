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

    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
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
    }
end

return M
