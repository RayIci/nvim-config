local M = {
    'Weissle/persistent-breakpoints.nvim',
}

function M.config()
    require "persistent-breakpoints".setup {
        load_breakpoints_event = { "BufReadPost" }
    }
end

return M
