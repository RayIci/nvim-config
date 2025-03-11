local M = {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
}

function M.config()
    vim.g.doge_enable_mappings = 1
    vim.g.doge_comment_type = "auto"
    vim.g.doge_doc_standard_python = "reST"
    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
        { "<leader>G", "<Plug>(doge-generate)", desc = "Docstring Generate" },
    }
end

return M
