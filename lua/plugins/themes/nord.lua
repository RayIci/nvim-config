local M = {
    "shaunsingh/nord.nvim",
}

function M.config()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = false
    vim.g.nord_italic = true
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    -- require("nord").set()
    -- vim.cmd("colorscheme nord")
end

return M
