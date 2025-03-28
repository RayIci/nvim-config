local M = {
    "mfussenegger/nvim-dap",
    dependencies = {

        -- Dap language specific packages
        "mfussenegger/nvim-dap-python",
    },
}

-- Mason data path
local mason_path = require "utils.mason".mason_data_path()


-- Functions that setup the python dap adapter
function M.python_dap_configure()
    pcall(function()
        require "dap-python".setup(mason_path .. "packages/debugpy/venv/bin/python")
    end)
end

function M.config()
    -- DAP config function
    M.python_dap_configure()

    M.keymaps()
end

function M.keymaps()
    require("which-key").add({
        { "<leader>d", group = "Debugger" },
        { "<leader>db", "<cmd>PBToggleBreakpoint<cr>", desc = "Breakpoint toggle" },
        { "<leader>dl", "<cmd>PBSetLogPoint<cr>", desc = "Brakepoint log" },
        { "<leader>dj", "<cmd>PBSetConditionalBreakpoint<cr>", desc = "Brakepoint conditional" },
        { "<leader>xb", "<cmd>PBClearAllBreakpoints<cr>", desc = "Brakepoint clear all" },
        {
            "<leader>dc",
            function()
                require("dap.ext.vscode").json_decode = vim.fn.json_decode
                require("dap.ext.vscode").load_launchjs(".vscode/launch.json", nil)
                require("dap").continue()
            end,
            desc = "Continue",
        },
        { "<leader>dr", "<cmd>lua require('dap').run()<cr>", desc = "Run" },
        { "<leader>dp", "<cmd>lua require('dap').pause()<cr>", desc = "Pause" },
        { "<leader>dk", "<cmd>lua require('dap').terminate()<cr>", desc = "Kill" },

        {
            "<leader>dT",
            "<cmd>lua require('nvim-dap-virtual-text').toggle()<cr>",
            desc = "Toggle Virtual Text",
        },

        {
            "<leader>ds",
            "<cmd>lua require('plugins.code.dap-ui').open_float('scopes')<cr>",
            desc = "Floating Scopes",
        },
        {
            "<leader>dS",
            "<cmd>lua require('plugins.code.dap-ui').open_float('stacks')<cr>",
            desc = "Floating Stacks",
        },
        {
            "<leader>dw",
            "<cmd>lua require('plugins.code.dap-ui').open_float('watches')<cr>",
            desc = "Floating Watches",
        },
        {
            "<leader>dB",
            "<cmd>lua require('plugins.code.dap-ui').open_float('breakpoints')<cr>",
            desc = "Floating Breakpoint",
        },
        {
            "<leader>dE",
            "<cmd>lua require('plugins.code.dap-ui').open_float('repl')<cr>",
            desc = "Floating Repl",
        },
        {
            "<leader>dC",
            "<cmd>lua require('plugins.code.dap-ui').open_float('console')<cr>",
            desc = "Floating Console",
        },
        {
            "<leader>do",
            require("plugins.code.dap-ui").toggle_floating_config,
            desc = "Toggle floating config",
        },
        {
            "<leader>de",
            "<cmd>lua require('dapui').eval()<cr>",
            desc = "Floating Evaluate",
        },

        {
            "<F5>",
            require("dap").continue,
            desc = "Debugger: continue",
        },
        {
            "<F1>",
            require("dap").step_into,
            desc = "Debugger: step into",
        },
        {
            "<F2>",
            require("dap").step_over,
            desc = "Debugger: step over",
        },
        {
            "<F3>",
            require("dap").step_out,
            desc = "Debugger: step out",
        },

        -- UI keymaps
        { "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle Ui" },
        { "<leader>dR", "<cmd>lua require('dapui').open({ reset = true })<cr>", desc = "Reset Ui" },
    })
end

return M
