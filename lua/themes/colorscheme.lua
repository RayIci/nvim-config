local themes = {
    gruvbox = "gruvbox",
    sonokai = "sonokai",
    vscode = "vscode",
    onedark = "onedark",
}

local selected_theme = themes.onedark

local M = {
    vim.tbl_extend("force", require("themes.all." .. selected_theme), { priority = 1000, lazy = false })
}

return M
