local M = {
    'projekt0n/github-nvim-theme',
    name = "github theme"
}

M.themes = {
    {
        name = "Github dark",
        colorscheme = "github_dark"
    },
    {
        name = "Github dark dimmed",
        colorscheme = "github_dark_dimmed"
    },
    {
        name = "Github dark default",
        colorscheme = "github_dark_default"
    },
}

function M.config()
    require 'github-theme'.setup {}

    -- github_dark
    -- github_light	
    -- github_dark_dimmed	
    -- github_dark_default
    -- github_light_default	
    -- github_dark_high_contrast	
    -- github_light_high_contrast
    -- github_dark_colorblind	
    -- github_light_colorblind
    -- github_dark_tritanopia
    -- github_light_tritanopia	
    -- vim.cmd('colorscheme github_dark')
end

return M
