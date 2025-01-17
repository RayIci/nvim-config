local M = {
    "folke/tokyonight.nvim",
    name = "tokyonight"
}

M.themes = {
    {
        name = "Tokyonight night",
        colorscheme = "tokyonight-night",
        before = [[vim.opt.background = "dark"]],
    },
    {
        name = "Tokyonight storm",
        colorscheme = "tokyonight-storm",
        before = [[vim.opt.background = "dark"]],
    },
}

function M.config()
    require "tokyonight".setup {}

    -- tokyonight-night
    -- tokyonight-storm
    -- tokyonight-day
    -- tokyonight-moon
    -- vim.cmd.colorscheme "tokyonight-storm"
end

return M
