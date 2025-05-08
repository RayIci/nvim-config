local M = {}

local linters_packages = {}
local formatter_packages = {}
local dap_packages = {}
local lsp_packages = {}

---Get the mason data path
---@return string
function M.get_mason_data_path()
    return vim.fn.stdpath("data") .. "/mason/"
end

---Get the mason bin path
---@return string
function M.get_mason_bin_path()
    return M.mason_data_path .. "bin/"
end

function M.install_packages()
    -- Add packages to vim PATH
    vim.env.PATH = M.get_mason_data_path() .. "bin:" .. vim.env.PATH

    -- Concat all packages
    local ensure_installed = require("mnvim.utils.tables").concat_lists(
        linters_packages,
        formatter_packages,
        lsp_packages,
        dap_packages
    )

    require("mason").setup({})
    require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        integrations = {
            ['mason-lspconfig'] = false, -- If true it cause an error 
            ['mason-null-ls'] = true,
            ['mason-nvim-dap'] = true,
        },
    })
end

---@alias PackageKind "linter" | "formatter" | "lsp" | "dap"

---@param kind PackageKind
---@param package string | table
function M.register_package(kind, package)
    if kind == "linter" then
        table.insert(linters_packages, package)
    elseif kind == "formatter" then
        table.insert(formatter_packages, package)
    elseif kind == "lsp" then
        table.insert(lsp_packages, package)
    elseif kind == "dap" then
        table.insert(dap_packages, package)
    else
        error("Invalid package kind: " .. kind)
    end
end

return M
