local M = {
    "nvimdev/lspsaga.nvim",
}

function M.config()
    require "lspsaga".setup {
        code_action = {
            enabled = false
        },
        ui = {
            code_action = require "utils.icons".ui.Lightbulb
        }
    }
end

return M
