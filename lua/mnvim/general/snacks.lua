mnvim.plugins.install({
    "folke/snacks.nvim",
    proprity = 1000,
    lazy = false,
})

local layout = "ivy"

mnvim.git.actions.lazygit_open = function()
    require("snacks").lazygit()
end

mnvim.git.actions.branch_select = function()
    require("snacks").picker.git_branches({ layout = layout })
end

mnvim.telescope.actions.pick_keymap = function()
    require("snacks").picker.keymaps({ layout = layout })
end
