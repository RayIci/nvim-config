_G.mnvim.code.dap = {}
_G.mnvim.code.dap.actions = {}

local adapters = {}
local configurations = {}

---@alias VirtualTextPosition "line-end"
---@type VirtualTextPosition|nil The position of the virtual text
mnvim.code.dap.virtual_text_position = "line-end"

---@class Adapter
---@field type string The adapter type (e.g. "executable")
---@field command string The command to run the adapter (e.g. "node")
---@field args string[]|nil The arguments to run the adapter (e.g. { "--nolazy" })

---Add an adapter
---@param adapter_name string the filetype where the adapter will be registered
---@param adapter Adapter the adapter
function mnvim.code.dap.adapter_add(adapter_name, adapter)
    adapters[adapter_name] = adapter
end

---Add a configuration
---@param configuration table The configuration table (eg talb ewith name, type, request, etc...)
function mnvim.code.dap.configurate(filetype, configuration)
    if configurations[filetype] == nil then
        configurations[filetype] = {}
    end

    local merged_configurations = require("mnvim.utils.tables").concat_lists(
        configurations[filetype],
        configuration
    )

    configurations[filetype] = merged_configurations
end

function mnvim.code.dap.actions.virtual_text_toggle()
    require("nvim-dap-virtual-text").toggle()
end

function mnvim.code.dap.actions.continue()
    require("dap").continue()
end

function mnvim.code.dap.actions.step_over()
    require("dap").step_over()
end

function mnvim.code.dap.actions.step_into()
    require("dap").step_into()
end

function mnvim.code.dap.actions.step_out()
    require("dap").step_out()
end

function mnvim.code.dap.actions.breakpoint_toggle()
    require("dap").toggle_breakpoint()
end

function mnvim.code.dap.actions.breakpoint_conditional_add()
    require("dap").toggle_breakpoint(vim.fn.input("Condition: "))
end

function mnvim.code.dap.actions.breakepoint_logpoint_add()
    require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

function mnvim.code.dap.actions.breakpoints_clear()
    require("dap").clear_breakpoints()
end

function mnvim.code.dap.actions.repl_toggle()
    require("dap").repl.toggle()
end

function mnvim.code.dap.actions.console_toggle()
    require("dap").repl.toggle()
end

function mnvim.code.dap.actions.run(config)
    require("dap").run(config)
end

function mnvim.code.dap.actions.run_last()
    require("dap").run_last()
end

function mnvim.code.dap.actions.terminate()
    require("dap").terminate()
end

function mnvim.code.dap.actions.pause()
    require("dap").pause()
end

mnvim.plugins.install({
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Virtual text
        "theHamsta/nvim-dap-virtual-text",

        -- Brakepoint persist
        -- "Weissle/persistent-breakpoints.nvim",
    },
    config = function ()
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
})
