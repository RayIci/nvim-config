local M = {
    'akinsho/git-conflict.nvim',
    version = "*"
}

function M.config()
    require "git-conflict".setup {
        default_mappings = false
    }
end

return M
