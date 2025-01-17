local selected_theme = "onedark"

local M = {
    vim.tbl_extend("force", require("themes.all." .. selected_theme), { priority = 1000, lazy = false })
}

return M
