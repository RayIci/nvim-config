local M = {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
}

function M.config()
    vim.g.doge_enable_mappings = 1
    vim.g.doge_comment_type = "auto"
    vim.g.doge_doc_standard_python = "reST"
end

return M
