local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
}

local map = require("utils.keymaps").map
function M.default_on_attach(client, bufnr)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr, desc = "Go declaration" })
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr, desc = "Go definition" })
    map("n", "<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, desc = "Signature help" })
    map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr, desc = "Go implementation" })
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr, desc = "Go references" })
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr, desc = "Go diagnostics" })
    map("n", "H", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end)

    -- Disable lsps formatting capabilities
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

function M.g_keymaps()
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format file" })
    map("x", "<leader>f", "<cmd>'<'>lua vim.lsp.buf.format({async = true})<CR>", { desc = "Format selection" })

    require("which-key").add({
        { "<leader>l", group = "LSP" },
        { "<leader>l", group = "LSP", mode = "v" },

        {
            "<leader>la",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            desc = "Code Action",
            mode = { "n", "v" },
        },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
        { "<leader>lh", "<cmd>lua require('code.lsp').toggle_inlay_hints()<cr>", desc = "Toggle inlay hints" },
        { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostics to quickfix" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    })

    -- Enable format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
end

function M.config()
    local lspconfig = require("lspconfig")
    local servers = require("plugins.code.mason").lsp_servers

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    M.g_keymaps()
    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.default_on_attach,
            capabilities = capabilities,
        }

        local require_ok, settings = pcall(require, "plugins.code.lsp-settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", opts, settings)
        end
        lspconfig[server].setup(opts)
    end
end

return M
