local M = {}

M.mason_lazy_plugin = {
    -- Mason to manage packages
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = true,
}

M.__diagnostic_packages = {}
M.__formatter_packages = {}
M.__dap_packages = {}
M.__lsp_packages = {}

---@alias PackageKind "diagnostic" | "formatter" | "lsp" | "dap"

---@param kind PackageKind
---@param package string | table
function M.register_package(kind, package)
    if kind == "diagnostic" then
        table.insert(M.__diagnostic_packages, package)
    elseif kind == "formatter" then
        table.insert(M.__formatter_packages, package)
    elseif kind == "lsp" then
        table.insert(M.__lsp_packages, package)
    elseif kind == "dap" then
        table.insert(M.__dap_packages, package)
    else
        error("Invalid package kind: " .. kind)
    end
end

function M.isntall_packages()
    -- Add packages to vim PATH
    vim.env.PATH = M.mason_data_path() .. "bin:" .. vim.env.PATH

    -- Concat all packages
    local ensure_installed = require("utils.tables").concat_lists(M.__diagnostic_packages, M.__formatter_packages, M.__lsp_packages, M.__dap_packages)
    require("mason").setup()
    require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        run_on_start = true,
        integrations = {
            ["mason-lspconfig"] = true,
            ["mason-null-ls"] = true,
            ["mason-nvim-dap"] = true,
        },
    })
end

---@return string
function M.mason_data_path()
    return vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
end

---@return string
function M.mason_bin_path()
    return M.mason_data_path() .. "bin/"
end

return M
