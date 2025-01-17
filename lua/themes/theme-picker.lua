local M = {
    "zaldih/themery.nvim",
    lazy = false,
}

function M.config()



   require "themery" .setup {}
end

return M
