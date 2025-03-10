local themes = {
    catppuccin = "catppuccin",
    gruvbox = "gruvbox",
    sonokai = "sonokai",
    vscode = "vscode",
    onedark = "onedark",
    vscode2 = "vscode2",
    rosepine = "rose-pine",
    vimcode = "vim-code",
    material = "material",
    github = "github"
}

local selected_theme = themes.catppuccin

local M = {
    vim.tbl_extend("force", require("themes.all." .. selected_theme), { priority = 1000, lazy = false })
}

return M
