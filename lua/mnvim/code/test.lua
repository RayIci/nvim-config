_G.mnvim.code.test = {}
_G.mnvim.code.test.actions = {}

local adapters_table = {}

---Add a test adapter
---@param adapter_function function a function that returns the adapter
mnvim.code.test.adapter_add = function(adapter_function)
    table.insert(adapters_table, adapter_function)
end

mnvim.plugins.install({
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local parsed_adapters = {}
        for _, adapter in ipairs(adapters_table) do
            table.insert(parsed_adapters, adapter())
        end

        require("neotest").setup({
            adapters = parsed_adapters,
        })
    end,
})

mnvim.code.test.actions.run = function()
    require("neotest").run.run()
end
mnvim.code.test.actions.run_last = function()
    require("neotest").run.run_last()
end
mnvim.code.test.actions.run_file = function()
    require("neotest").run.run(vim.fn.expand("%"))
end
mnvim.code.test.actions.run_all = function()
    require("neotest").run.run({ suite = true })
end
mnvim.code.test.actions.run_debugging = function()
    require("neotest").run.run({ strategy = "dap" })
end
mnvim.code.test.actions.stop = function()
    require("neotest").run.stop()
end
mnvim.code.test.actions.attach = function()
    require("neotest").run.attach()
end
mnvim.code.test.actions.watch_toggle_file = function()
    require("neotest").watch.toggle(vim.fn.expand("%"))
end
mnvim.code.test.actions.watch_toggle = function()
    require("neotest").watch.toggle()
end
mnvim.code.test.actions.output_open = function()
    require("neotest").output.open()
end
mnvim.code.test.actions.output_close = function()
    require("neotest").output.close()
end
mnvim.code.test.actions.output_panel_toggle = function()
    require("neotest").output_panel.toggle()
end
mnvim.code.test.actions.summary_toggle = function()
    require("neotest").summary.toggle()
end
