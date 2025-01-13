local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
}

function M.icons_setup()
    local sign = vim.fn.sign_define
    local sethl = vim.api.nvim_set_hl
    local icons = require("icons")

    sign("DapBreakpoint", { text = icons.debugger.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
    sign(
        "DapBreakpointCondition",
        { text = icons.debugger.BreakpointCondition, texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    sign("DapLogPoint", { text = icons.debugger.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
    sign(
        "DapStopped",
        { text = icons.debugger.DapStopped, texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )
    sethl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" })
    sethl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    sethl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
end

function M.config()
    -- DAP and DAPui
    local dap = require("dap")
    local dapui = require("dapui")

    -- Virtual text setup
    require("nvim-dap-virtual-text").setup({})

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    M.icons_setup()

    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes",      size = 0.25 },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 0.25 },
                },
                size = 40,
                position = "left",
            },
            {
                elements = {
                    { id = "repl",    size = 0.5 },
                    { id = "console", size = 0.5 },
                },
                size = 15,
                position = "bottom",
            },
        },
        floating = {
            border = "rounded",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = {
            indent = 1,
        },
        force_buffers = true,
    })
end

return M
