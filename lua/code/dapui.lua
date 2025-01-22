local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
}

M.default_config = true

function M.toggle_floating_config()
    M.default_config = not M.default_config
end

function M.get_floating_config()
    if M.default_config then
        return {
            enter = true,
            width = vim.o.columns,
            height = vim.o.lines,
        }
    end

    return { enter = true }
end

function M.open_float(window)
    require "dapui".float_element(window, M.get_floating_config())
end

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

    -- dap.listeners.before.attach.dapui_config = function()
    --     dapui.open()
    -- end
    -- dap.listeners.before.launch.dapui_config = function()
    --     dapui.open()
    -- end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --     dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --     dapui.close()
    -- end

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
            max_height = 0.99,
            max_width = 0.99,
        },
        windows = {
            indent = 1,
        },
        force_buffers = true,
    })
end

return M
