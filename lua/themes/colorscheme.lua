local selected_theme = "vscode"

local M = {
    vim.tbl_extend("force", require("themes.all." .. selected_theme), { priority = 1000, lazy = false })
}

--
-- local require_ok, theme = pcall(require, "themes.all" .. selected_theme)
-- vim.print("HERE BABY: " .. (require_ok and "true" or "false") )
-- if require_ok then
--     vim.print("INSIDE")
--     vim.tbl_extend("force", M, theme, { priority = 1000 })
-- end
--
-- local vscode_theme = require("themes.all.vscode")
-- vim.tbl_extend("force", M, vscode_theme, { priority = 1000 })
-- vim.print("M: " .. M)

return M
