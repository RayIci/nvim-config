local M = {
    "folke/tokyonight.nvim",
    name = "tokyonight",
}

function M.config()
    require("tokyonight").setup({})

    -- tokyonight-night
    -- tokyonight-storm
    -- tokyonight-day
    -- tokyonight-moon
    -- vim.cmd.colorscheme("tokyonight-storm")
end

return M
