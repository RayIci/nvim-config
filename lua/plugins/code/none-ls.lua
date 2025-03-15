-- For extra see https://github.com/nvimtools/none-ls-extras.nvim

local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
}

function M.map_servers_sources(server)
    local map_servers_sources = {
        ["eslint_d"] = require("none-ls.diagnostics.eslint_d")
    }

    return map_servers_sources[server]
end

function M.config()
    -- Get the servers configurations
    local formatting_servers = require "plugins.code.mason".none_ls_servers_formatting
    local diagnostics_servers = require "plugins.code.mason".none_ls_servers_diagnostics

    -- Create the source table taking also servers configurations
    local diagnostics_sources = M.execute_none_ls_servers(diagnostics_servers, "diagnostics")
    local formattings_sources = M.execute_none_ls_servers(formatting_servers, "formatting")
    local sources = require "utils.tables".concat_tables(diagnostics_sources, formattings_sources)

    -- Enable format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    require("null-ls").setup({
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

function M.execute_none_ls_servers(mason_servers, kind)
    local null_ls = {}
    if kind == "diagnostics" then
        null_ls = require "null-ls".builtins.diagnostics
    elseif kind == "formatting" then
        null_ls = require "null-ls".builtins.formatting
    elseif kind == "code-actions" then
        null_ls = require "null-ls".builtins.code_actions
    end

    local sources = {}
    for _, server in pairs(mason_servers) do
        local opts = {}

        local require_ok, settings = pcall(require, "plugins.code.none-ls-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        local custom_map = M.map_servers_sources(server)

        if custom_map ~= nil then
            if next(opts) ~= nil then
                table.insert(sources, custom_map.with(opts))
            else
                table.insert(sources, custom_map)
            end
        else
            server = string.gsub(server, "%-", "_")
            if next(opts) ~= nil then
                table.insert(sources, null_ls[server].with(opts))
            else
                table.insert(sources, null_ls[server])
            end
        end
    end

    return sources
end

return M
