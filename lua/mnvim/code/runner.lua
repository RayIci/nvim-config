_G.mnvim.code.runner = {}
_G.mnvim.code.runner.actions = {}

mnvim.plugins.install({
    "stevearc/overseer.nvim",
    config = function()
        require("overseer").setup({
            task_list = {
                min_height = 30,
            },
        })
    end,
})

mnvim.code.runner.actions.ui_toggle = function()
    require("overseer").toggle({
        enter = true,
    })
end

mnvim.code.runner.actions.run = function()
    vim.cmd("OverseerRun")
end
