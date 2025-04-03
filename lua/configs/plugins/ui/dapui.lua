local dapui = require("dapui")

-- Floating panel functions
local toggle_floating = function(dapui_panel)
    dapui.float_element(dapui_panel, {
        enter = true,
        width = vim.o.columns,
        height = vim.o.lines,
    })
end
local toggle_scopes = function()
    toggle_floating("scopes")
end
local toggle_stacks = function()
    toggle_floating("stacks")
end
local toggle_watches = function()
    toggle_floating("watches")
end
local toggle_breakpoints = function()
    toggle_floating("breakpoint ")
end
local toggle_repl = function()
    toggle_floating("repl")
end
local toggle_console = function()
    toggle_floating("console")
end

-- UI keymaps
local map = require("utils.keymaps").map

-- ui panels keymaps
map("n", "<leader>dt", dapui.toggle, { desc = "Toggle ui" })
map("n", "<leader>dR", "<cmd>lua require('dapui').open({ reset = true })<cr>", { desc = "Reset ui" })

-- floating panels keymaps
map("n", "<leader>ds", toggle_scopes, { desc = "Floating Scopes" })
map("n", "<leader>dS", toggle_stacks, { desc = "Floating Stacks" })
map("n", "<leader>dw", toggle_watches, { desc = "Floating Watches" })
map("n", "<leader>dB", toggle_breakpoints, { desc = "Floating Breakpoint" })
map("n", "<leader>dE", toggle_repl, { desc = "Floating Repl" })
map("n", "<leader>dC", toggle_console, { desc = "Floating Console" })
map("n", "<leader>de", dapui.eval, { desc = "Floating Evaluate" })

-- UI setup
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 15,
            position = "bottom",
        },
    },
    floating = {
        -- border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
        max_height = 0.99,
        max_width = 0.99,
    },
})

-- Set exit insert mode from dapui terminal
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*dap-terminal*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
    end,
})

-- Icons setup
local sign = vim.fn.sign_define
local icons = require("utils.icons")

sign("DapBreakpoint", { text = icons.debugger.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = icons.debugger.BreakpointCondition, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = icons.debugger.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = icons.debugger.DapStopped, texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
