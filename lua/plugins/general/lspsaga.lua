local M = {
    "nvimdev/lspsaga.nvim",
}

function M.config()
   require "lspsaga".setup {}
end

return M
