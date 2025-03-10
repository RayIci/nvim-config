-- For extra see https://github.com/nvimtools/none-ls-extras.nvim

local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local formatting_servers = require "plugins.code.mason".none_ls_servers_formatting
    local diagnostics_servers = require "plugins.code.mason".none_ls_servers_diagnostics

    local sources = {}

    -- Add formatters options
    for _, server in pairs(formatting_servers) do
        local opts = {}

        local require_ok, settings = pcall(require, "plugins.code.none-ls-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        local formatting_server = string.gsub(server, "%-", "_")

        if next(opts) ~= nil then
            table.insert(sources, formatting[formatting_server].with(opts))
        else
            table.insert(sources, formatting[formatting_server])
        end
    end

    -- Add linters options
    for _, server in pairs(diagnostics_servers) do
        local opts = {}

        local require_ok, settings = pcall(require, "plugins.code.none-ls-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        local diagnostic_server = string.gsub(server, "%-", "_")

        if next(opts) == nil then
            table.insert(sources, diagnostics[diagnostic_server].with(opts))
        else
            table.insert(sources, diagnostics[diagnostic_server])
        end
    end


    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
        debug = true,
        sources = sources,
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
