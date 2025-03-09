local M = {
    "nvim-treesitter/nvim-treesitter-context",
    dependecies = {
        "nvim-treesitter/nvim-treesitter"
    }
}

function M.config()
    require 'treesitter-context'.setup {
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
    }
end

return M
