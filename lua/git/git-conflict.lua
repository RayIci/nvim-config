local M = {
    'akinsho/git-conflict.nvim',
    version = "*"
}

function M.config()
    require "git-conflict".setup {}
end

return M
