local register_package = require("configs.mason").register_package

register_package("diagnostic", "hadolint")
register_package("diagnostic", "sqlfluff")
register_package("formatter", "prettier")
register_package("formatter", "shfmt")
register_package("formatter", "black")
register_package("formatter", "isort")
register_package("formatter", "clang-format")
register_package("formatter", "rustywind")
register_package("formatter", "sqlfmt")
register_package("formatter", "stylua")
register_package("formatter", "csharpier")

-- Keymaps
local map = require("utils.keymaps").map
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format file" })
map("x", "<leader>f", "<cmd>'<'>lua vim.lsp.buf.format({async = true})<CR>", { desc = "Format selection" })

-- None-ls configurations and setups
local diagnostics = require("null-ls").builtins.diagnostics
local formatters = require("null-ls").builtins.formatting

local sources = {
    -- DIAGNOSTICS

    -- Dockerfile linter
    diagnostics.hadolint,

    -- SQL linter
    diagnostics.sqlfluff.with({
        extra_args = {
            "--dialect",
            "postgres",
            "--exclude-rules",
            "layout.indent,layout.cte_bracket,layout.select_targets,layout.spacing",
        },
    }),

    -- Typescript/Javascript linter
    -- require("none-ls.diagnostics.eslint_d"),

    -- FORMATTERS

    -- ts/js formatter
    formatters.prettier,

    -- Shell formatter
    formatters.shfmt.with({
        args = { "-i", "4" },
    }),

    -- Python formatter
    formatters.black,

    -- Python import sorter
    formatters.isort.with({
        extra_args = { "--profile", "black" },
    }),

    -- C & C++ formatter
    formatters.clang_format.with({
        filetypes = { "c", "cpp" },
    }),

    -- Tailwind classes organizer
    formatters.rustywind,

    -- SQL formatter
    formatters.sqlfmt,

    -- Lua formatter
    formatters.stylua,

    -- Lua formatter
    formatters.csharpier,
}

-- Setup none-ls
require("null-ls").setup({
    debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
        -- Autosave on file save
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
