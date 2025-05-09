local M = {}

local adapters = {}
local configurations = {}

function M.config()
    -- Setup breakpoints persist
    -- require("persistent-breakpoints").setup({
    --     load_breakpoints_event = { "BufReadPost" },
    -- })

    -- Setup virtual text
    local converted_virtual_text_position = nil
    if mnvim.code.dap.virtual_text_position == "line-end" then
        converted_virtual_text_position = "eol"
    end
    require("nvim-dap-virtual-text").setup({
        virt_text_pos = converted_virtual_text_position,
    })

    local dap = require("dap")

    -- Setup adapters
    for adapter_name, adapter in pairs(adapters) do
        dap.adapters[adapter_name] = adapter
    end

    -- Setup configurations
    for filetype, configuration in pairs(configurations) do
        dap.configurations[filetype] = require("mnvim.utils.tables").concat_lists(
            dap.configurations[filetype] or {},
            configuration
        )
    end
end

---@class Adapter
---@field type string The adapter type (e.g. "executable")
---@field command string The command to run the adapter (e.g. "node")
---@field args string[]|nil The arguments to run the adapter (e.g. { "--nolazy" })

---Add an adapter
---@param adapter_name string the filetype where the adapter will be registered
---@param adapter Adapter the adapter
function M.add_adapter(adapter_name, adapter)
    adapters[adapter_name] = adapter
end

---Add a configuration
---@param configuration table The configuration table (eg talb ewith name, type, request, etc...)
function M.add_configuration(filetype, configuration)
    if configurations[filetype] == nil then
        configurations[filetype] = {}
    end

    local merged_configurations = require("mnvim.utils.tables").concat_lists(
        configurations[filetype],
        configuration
    )

    configurations[filetype] = merged_configurations
end

function M.toggle_virtual_text()
    require("nvim-dap-virtual-text").toggle()
end

function M.continue()
    require("dap").continue()
end

function M.step_over()
    require("dap").step_over()
end

function M.step_into()
    require("dap").step_into()
end

function M.step_out()
    require("dap").step_out()
end

function M.breakpoint_toggle()
    require("dap").toggle_breakpoint()
end

function M.breakpoint_conditional_add()
    require("dap").toggle_breakpoint(vim.fn.input("Condition: "))
end

function M.breakepoint_logpoint_add()
    require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

function M.breakpoints_clear()
    require("dap").clear_breakpoints()
end

function M.repl_toggle()
    require("dap").repl.toggle()
end

function M.console_toggle()
    require("dap").repl.toggle()
end

function M.run(config)
    require("dap").run(config)
end

function M.run_last()
    require("dap").run_last()
end

function M.terminate()
    require("dap").terminate()
end

function M.pause()
    require("dap").pause()
end

return M
