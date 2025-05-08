local M = {}


local on_attach_functions = {}
local on_attach = function (client, bufnr)
    -- KEYMAPS ON LSP ATTACH

    -- Refresh code lenses
    vim.cmd("autocmd BufEnter,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = " .. bufnr .. " })")

    -- Disable lsps formatting capabilities
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Custom on attach
    for _, on_attach_function in pairs(on_attach_functions) do
        on_attach_function(client, bufnr)
    end
end

---@param on_attach_function function function with first argument the client and the buffer
---number as second argument
function M.add_on_attach_function(on_attach_function)
    table.insert(on_attach_functions, on_attach_function)
end

---@class LspConfig
---@field on_attach function|nil a custom on_attach function or default on nil
---@field capabilities table|nil a custom capabilities or default on nil
---@field settings table|nil the lsp settings
local lsp_config_list = {}

---Register an lsp
---@param lsp_server string The lsp server name
---@param lsp_config LspConfig | nil
function M.register_lsp_server(lsp_server, lsp_config)
    lsp_config_list[lsp_server] = lsp_config or {}
end

-- Use by lazy to configure lsp
function M.config()
    local lspconfig = require("lspconfig")

    -- Set default capabilities
    local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
    if mnvim.code.lsp.modify_capabilities ~= nil then
        default_capabilities = mnvim.code.lsp.modify_capabilities(default_capabilities)
    end

    for lsp_server, lsp_config in pairs(lsp_config_list) do
        lspconfig[lsp_server].setup({
            on_attach = lsp_config.on_attach or on_attach,
            capabilities = default_capabilities,
            settings = lsp_config.settings or {},
        })
    end
end

return M
