local M = {}

function M.configure(plugin)
    return function()
        require("configs.plugins." .. plugin)
    end
end

return M
