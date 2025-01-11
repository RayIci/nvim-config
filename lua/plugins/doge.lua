local M = {
    "kkoomen/vim-doge",
    -- Installa i template dei linguaggi
    -- TODO: See if it's ok otherwise need to :call doge#install() from cmdline
    build = ":call doge#install()",
}

function M.config()
    vim.g.doge_enable_mappings = 1
    vim.g.doge_comment_type = "auto"
    vim.g.doge_doc_standard_python = "reST"
end

return M
