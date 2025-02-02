-- For extra see https://github.com/nvimtools/none-ls-extras.nvim

local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
}

function M.sources(formatting, diagnostics)
    return {
        formatting.prettier,
        -- formatting.stylua,
        formatting.shfmt.with({ args = { "-i", "4" } }),
        formatting.csharpier,
        formatting.rustywind,
        formatting.black,
        formatting.isort.with({ extra_args = { "--profile", "black" } }),
        formatting.clang_format,

        diagnostics.hadolint,
    }
end

function M.config()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
        debug = true,
        sources = M.sources(formatting, diagnostics),
        on_attach = function(client, bufnr)
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
end

return M
