_G.mnvim.code.treesitter = {}
_G.mnvim.code.treesitter.indent = {}
_G.mnvim.code.treesitter.highlight = {}
_G.mnvim.code.treesitter.incremental_selection = {}

---@type string[]
mnvim.code.treesitter.install = {}
---@type string[]
mnvim.code.treesitter.ignore = {}

---@type boolean
mnvim.code.treesitter.highlight.enabled = true
---@type string[]
mnvim.code.treesitter.highlight.disabled_filetypes = {}
---@type number | nil max file size in bytes
---(100 * 1024 = 100kb). nil means no limit
mnvim.code.treesitter.highlight.max_filesize = 100 * 1024

---@type boolean
mnvim.code.treesitter.indent.enabled = true

---@type integer
mnvim.code.treesitter.multiline_threshold = 1

---@type boolean
mnvim.code.treesitter.incremental_selection.enabled = true

---@class IncrementalSelectionKeymaps
---@field init_selection string|nil
---@field node_incremental string|nil
---@field scope_incremental string|nil
---@field node_decremental string|nil
mnvim.code.treesitter.incremental_selection.keymaps = {
    init_selection = "<c-space>",
    node_incremental = "<c-space>",
    scope_incremental = nil,
    node_decremental = nil,
}

mnvim.plugins.install({
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "LiadOz/nvim-dap-repl-highlights",
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        -- Setup treesitter context
        require("treesitter-context").setup({
            -- Maximum number of lines to show for a single context
            multiline_threshold = mnvim.code.treesitter.multiline_threshold,
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
                enabled = true,
                keymaps = {
                    init_selection = mnvim.code.treesitter.incremental_selection.keymaps.init_selection,
                    node_incremental = mnvim.code.treesitter.incremental_selection.keymaps.node_incremental,
                    scope_incremental = mnvim.code.treesitter.incremental_selection.keymaps.scope_incremental,
                    node_decremental = mnvim.code.treesitter.incremental_selection.keymaps.node_decremental,
                },
            },
            disable = function(lang, buf)
                for _, ft in pairs(mnvim.code.treesitter.highlight.disabled_filetypes) do
                    if ft == lang then
                        return true
                    end
                end

                if mnvim.code.treesitter.highlight.max_filesize == nil then
                    return false
                end

                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > mnvim.code.treesitter.highlight.max_filesize then
                    return true
                end
            end,
        })
    end,
})
