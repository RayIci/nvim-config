local M = {
    'sainnhe/sonokai',
    name = "sonokai"
}

M.themes = {
    {
        name = "Sonokai",
        colorscheme = "sonokai",
        before = [[vim.opt.background = "dark"]],
    }
}

function M.config()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.sonokai_enable_italic = true
    -- vim.cmd.colorscheme('sonokai')
end

return M
