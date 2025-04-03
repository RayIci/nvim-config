local M = {
    "rose-pine/neovim",
    name = "rose-pine",
}

function M.config()
    require("rose-pine").setup({
        variant = "moon", -- auto,main, moon or dawn
    })

    -- vim.cmd.colorscheme("rose-pine")
end

return M
