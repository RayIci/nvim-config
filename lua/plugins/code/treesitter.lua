local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
}
function M.config()
    local treesitter_configs = require("nvim-treesitter.configs")
    treesitter_configs.setup({
        ignore_install = {},
        modules = {},
        auto_install = true,
        ensure_installed = {
            "c_sharp",
            "cpp",
            "c",
            "make",
            "cmake",
            "javascript",
            "typescript",
            "tsx",
            "html",
            "css",
            "python",
            "yaml",
            "sql",
            "bash",
            "markdown",
            "markdown_inline",
            "lua",
            "latex",
            "csv",
            "dockerfile",
            "xml",
        },
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    })
end

return M
