local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp"
    },
}

-- Buffer keymaps settings
local function lsp_keymaps(bufnr)
    local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc, noremap = true, silent = true })
    end

    map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go declaration", "n")
    map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go definition", "n")
    map("<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help", "n")
    map("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go implementation", "n")
    map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go references", "n")
    map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Go diagnostics", "n")

    require("utils").keymap("n", "H", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end)
end


-- On LSP attach function
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(true)
    end
end


-- Inlay hints function
M.toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end


-- Common LSP capabilities
function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    return capabilities
end

-- LSP config configuration
function M.config()
    local lspconfig = require "lspconfig"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local servers = require "code.mason".lsp_servers
    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "code.lsp-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end
end

return M
