local M = {}

function M.config()
    -- Setup treesitter context
    require("treesitter-context").setup({
        multiline_threshold = 1,     -- Maximum number of lines to show for a single context
    })

    -- Setup repl higlights (add repl treesitter colors)
    require("nvim-dap-repl-highlights").setup()

    -- Setup treesitter
    require("nvim-treesitter.configs").setup({
        ignore_install = mnvim.code.treesitter.ignore,
        auto_install = true,
        ensure_installed = mnvim.code.treesitter.install,
        sync_install = false,
        highlight = {
            enable = mnvim.code.treesitter.highlight.enabled,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = mnvim.code.treesitter.indent.enabled },
        incremental_selection = {
            init_selection = mnvim.code.treesitter.incremental_selection.keymaps.init_selection,
            node_incremental = mnvim.code.treesitter.incremental_selection.keymaps.node_incremental,
            scope_incremental = mnvim.code.treesitter.incremental_selection.keymaps.scope_incremental,
            node_decremental = mnvim.code.treesitter.incremental_selection.keymaps.node_decremental,
        },
        disable = function (lang, buf)
            for _, ft in pairs(mnvim.code.treesitter.highlight.disabled_filetypes) do
                if ft == lang then
                    return true
                end
            end

            if mnvim.code.treesitter.highlight.max_filesize == nil then
                return false
            end

            local max_filesize = 100 * 1024     -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > mnvim.code.treesitter.highlight.max_filesize then
                return true
            end
        end,
    })
end

return M
