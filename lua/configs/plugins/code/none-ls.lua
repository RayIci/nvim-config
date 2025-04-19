local mason_packages = {
    -- DIAGNOSTICS/LINTERS
    "hadolint", -- Dockerfile linter
    "sqlfluff", -- SQL linter
    -- "eslint_d", -- ts/js linter

    -- FORMATTERS
    "prettier", -- ts/js formatter
    "shfmt", -- Shell formatter
    "black", -- Python formatter
    "isort", -- Python import sorter
    "clang-format", -- C & C++ formatter
    "rustywind", -- tailwind classes organizer
    "sqlfmt", -- SQL formatter
    "stylua", -- Lua formatter
    "csharpier ", -- C# formatter
}

-- Mason packages install
require("mason-null-ls").setup({
    ensure_installed = mason_packages,
    automatic_installation = true,
})

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
