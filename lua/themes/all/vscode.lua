local M = {
    'Mofiqul/vscode.nvim',
    name = "vscode"
}

function M.config()
    local c = require('vscode.colors').get_colors()
    require('vscode').setup({
        -- Alternatively set style in setup
        -- style = 'light'


        transparent = false,        -- Enable transparent background
        italic_comments = true,     -- Enable italic comment
        underline_links = true,     -- Underline `@markup.link.*` variants
        disable_nvimtree_bg = true, -- Disable nvim-tree background color

        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
            vscLineNumber = '#FFFFFF',
        },

        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
            -- this supports the same val table as vim.api.nvim_set_hl
            -- use colors from this colorscheme by requiring vscode.colors!
            Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        }
    })

    -- require('vscode').load()

    -- load the theme without affecting devicon colors.
    vim.o.background = 'dark'
    vim.cmd.colorscheme "vscode"
end

return M
