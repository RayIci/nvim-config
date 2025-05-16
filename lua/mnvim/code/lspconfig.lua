_G.mnvim.code.lsp = {}
_G.mnvim.code.lsp.actions = {}

mnvim.code.lsp.actions = {}
mnvim.code.lsp.actions.definition = function()
    vim.lsp.buf.definition()
end
mnvim.code.lsp.actions.declaration = function()
    vim.lsp.buf.declaration()
end
mnvim.code.lsp.actions.implementation = function()
    vim.lsp.buf.implementation()
end
mnvim.code.lsp.actions.references = function()
    vim.lsp.buf.references()
end
mnvim.code.lsp.actions.hover = function()
    vim.lsp.buf.hover()
end
mnvim.code.lsp.actions.rename = function()
    vim.lsp.buf.rename()
end
mnvim.code.lsp.actions.code_lens = function()
    vim.lsp.codelens.run()
end
mnvim.code.lsp.actions.code_action = function()
    require("actions-preview").code_actions()
end

---@type function|nil Function that modifies the capabilities when assigned
---to a server. It takes in input the capabilities table and must returns
---the modified table
mnvim.code.lsp.modify_capabilities = nil

local on_attach_functions = {}
---Add a function that will be called after the default on attach functionalities.
---If you want to use a new on_attach function that does not call the default one,
---set a on_attach function for each registered server.
---@param on_attach_function function function with first argument the client and the buffer
---number as second argument
function mnvim.code.lsp.add_on_attach_function(on_attach_function)
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
function mnvim.code.lsp.register(lsp_server, lsp_config)
    lsp_config_list[lsp_server] = lsp_config or {}
end

local on_attach = function(client, bufnr)
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

mnvim.plugins.install({
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "aznhe21/actions-preview.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")

        -- Set default capabilities
        local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
        if mnvim.code.lsp.modify_capabilities ~= nil then
            default_capabilities = mnvim.code.lsp.modify_capabilities(default_capabilities)
        end

        for lsp_server, lsp_config in pairs(lsp_config_list) do
            local opts = {
                on_attach = lsp_config.on_attach or on_attach,
                capabilities = default_capabilities,
            }
            if lsp_config ~= nil then
                opts = vim.tbl_deep_extend("force", opts, lsp_config)
            end
            lspconfig[lsp_server].setup(opts)
        end
    end,
})
