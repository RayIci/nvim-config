local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
}

-- Global keymaps
function M.g_keymaps()
    require("which-key").add({
        -- Formatting
        { "<leader>f",  "<cmd>lua vim.lsp.buf.format({async = true})<cr>",       desc = "Format file" },
        {
            "<leader>f",
            "<cmd>'<'>lua vim.lsp.buf.format({async = true})<CR>",
            desc = "Format selection",
            mode = { "v" },
        },

        { "<leader>l",  group = "LSP" },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                desc = "Code Action" },
        { "<leader>li", "<cmd>LspInfo<cr>",                                      desc = "Info" },
        { "<leader>lh", "<cmd>lua require('code.lsp').toggle_inlay_hints()<cr>", desc = "Hints" },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",                   desc = "CodeLens Action" },
        { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",              desc = "Quickfix" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                     desc = "Rename" },
        { "<leader>l",  group = "LSP",                                           mode = "v" },
        {
            "<leader>la",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            desc = "Code Action",
            mode = { "v" },
        },
    })
end

-- Buffer keymaps settings
function M.keymaps(bufnr)
    local map = require("utils.keymaps").map

    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr, desc = "Go declaration" })
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr, desc = "Go definition" })
    map("n", "<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature help" })
    map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr, desc = "Go implementation" })
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr, desc = "Go references" })
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr, desc = "Go diagnostics" })

    map("n", "H", function()
        -- local winid = require("ufo").peekFoldedLinesUnderCursor()
        -- if not winid then
        --     vim.lsp.buf.hover()
        -- end

        vim.lsp.buf.hover()
    end)
end

-- On LSP attach function
M.on_attach = function(client, bufnr)
    M.keymaps(bufnr)

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
    end
end

-- Inlay hints function
M.toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end

-- Common LSP capabilities
function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local cmp_capabilities = {}
    if status_ok then
        cmp_capabilities = cmp_nvim_lsp.default_capabilities()
    end

    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    client_capabilities.textDocument.completion.completionItem.snippetSupport = true
    client_capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    client_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    local capabilities = {}
    vim.tbl_deep_extend("force", capabilities, client_capabilities)
    vim.tbl_deep_extend("force", capabilities, cmp_capabilities)

    return capabilities
end

-- Handlers setup
function M.handlers_setup()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})                  -- { border = "rounded" }
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {}) -- { border = "rounded" }
    -- require("lspconfig.ui.windows").default_options.border = "rounded"
end

-- LSP config configuration
function M.config()
    local lspconfig = require("lspconfig")
    local servers = require("plugins.code.mason").lsp_servers

    -- Setup handlers
    M.handlers_setup()

    -- Global keymaps
    M.g_keymaps()

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "plugins.code.lsp-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end
        lspconfig[server].setup(opts)
    end
end

return M
