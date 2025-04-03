-- Setup mason packages
local mason_packages = {
    "python",
    "netcoredbg",
}

require("mason-nvim-dap").setup({
    ensure_installed = mason_packages,
    automatic_installation = true,
})

-- Setup breakpoints persist
require("persistent-breakpoints").setup({
    load_breakpoints_event = { "BufReadPost" },
})

-- Setup virtual text
require("nvim-dap-virtual-text").setup({
    virt_text_pos = "eol",
})

-- DAP configurations
local mason_path = require("utils.mason").mason_data_path()
local mason_bin_path = require("utils.mason").mason_bin_path()

-- Python
require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

-- Dotnet/C#
require("dap-cs").setup({
    --  For more details do :help dap-configuration
    dap_configurations = {
        {
            type = "coreclr",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },
    netcoredbg = {
        path = mason_bin_path .. "netcoredbg",
    },
})

-- KEYMAPS
local dap = require("dap")
local map = require("utils.keymaps").map
local vrtext = require("nvim-dap-virtual-text")

require("which-key").add({
    { "<leader>d", group = "Debugger" },
})

-- virtual text keymaps
map("n", "<leader>dT", vrtext.toggle, { desc = "Toggle virtual text" })

-- brakepoint keymaps
map("n", "<leader>db", "<cmd>PBToggleBreakpoint<cr>", { desc = "Breakpoint toggle" })
map("n", "<leader>dl", "<cmd>PBSetLogPoint<cr>", { desc = "Brakepoint log" })
map("n", "<leader>dj", "<cmd>PBSetConditionalBreakpoint<cr>", { desc = "Brakepoint conditional" })
map("n", "<leader>xb", "<cmd>PBClearAllBreakpoints<cr>", { desc = "Brakepoint clear all" })

map("n", "<leader>dr", "<cmd>lua require('dap').run()<cr>", { desc = "Run" })
map("n", "<leader>dp", "<cmd>lua require('dap').pause()<cr>", { desc = "Pause" })
map("n", "<leader>dk", "<cmd>lua require('dap').terminate()<cr>", { desc = "Kill" })

-- debugger keymaps
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<F5>", dap.continue, { desc = "Debugger: continue" })
map("n", "<F1>", dap.step_into, { desc = "Debugger: step into" })
map("n", "<F2>", dap.step_over, { desc = "Debugger: step over" })
map("n", "<F3>", dap.step_out, { desc = "Debugger: step out" })
