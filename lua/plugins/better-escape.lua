local M = {
    "max397574/better-escape.nvim"
}

function M.config()
    require "better_escape".setup {
        clear_empty_lines = false,
    }
end

return M
