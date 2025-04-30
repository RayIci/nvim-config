-- Setup mason lsp packages
local register_package = require("configs.mason").register_package
register_package("lsp", "pyright")
register_package("lsp", "ts_ls")
register_package("lsp", "tailwindcss")
register_package("lsp", "texlab")
register_package("lsp", "omnisharp")
register_package("lsp", "clangd")
register_package("lsp", "cmake")
register_package("lsp", "docker_compose_language_service")
register_package("lsp", "dockerls")
register_package("lsp", "lua_ls")
register_package("lsp", "sqlls")

local map = require("utils.keymaps").map
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })

local on_attach = function(client, bufnr)
    -- KEYMAPS ON LSP ATTACH
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr, desc = "Go declaration" })
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr, desc = "Go definition" })
    map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr, desc = "Go implementation" })
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr, desc = "Go references" })

    map({ "n", "i" }, "<M-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature help" })

    require("which-key").add({
        { "<leader>l", group = "LSP" },
        { "<leader>l", group = "LSP", mode = "v" },
    })
    map({ "n", "v" }, "<leader>la", require("actions-preview").code_actions, { desc = "Code action" })
    map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
    map("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", { buffer = bufnr, desc = "Code lense" })

    map("n", "H", function()
        -- local winid = require("ufo").peekFoldedLinesUnderCursor()
        -- if not winid then
        --     vim.lsp.buf.hover()
        -- end
        vim.lsp.buf.hover()
    end)

    -- Refresh code lenses
    vim.cmd("autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = bufnr })")

    -- OTHER ON ATTACH CONFIGURATIONS
    -- Disable lsps formatting capabilities
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

-- LSPconfig and Capabilites
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Utility to load servers with configurations
local setup_server = function(server, opts)
    local ok, settings = pcall(require, "configs.plugins.code.lsp-server-cofigs." .. server)
    if ok then
        opts = vim.tbl_deep_extend("force", opts, settings)
    end
    lspconfig[server].setup(opts)
end

-- Python
setup_server("pyright", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Typescript
setup_server("ts_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Tailwind
setup_server("tailwindcss", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Latex
setup_server("texlab", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- C#
setup_server("omnisharp", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- C and C++
setup_server("clangd", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Cmake
setup_server("cmake", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Docker compose
setup_server("docker_compose_language_service", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Docker
setup_server("dockerls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- Lua
setup_server("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
-- SQL
setup_server("sqlls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
