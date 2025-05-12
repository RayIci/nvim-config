_G.mnvim.code.packages = {}

local linters_packages = {}
local formatter_packages = {}
local dap_packages = {}
local lsp_packages = {}

---Open the package manager ui
function mnvim.code.packages.open_ui()
    vim.cmd("Mason")
end

---Get the package manager data path
---@return string the path to the package manager
function mnvim.code.packages.get_data_path()
    return vim.fn.stdpath("data") .. "/mason/"
end

---Get the package manager bin path
---@return string the path to the package manager bin
function mnvim.code.packages.get_bin_path()
    return mnvim.code.packages.get_data_path() .. "bin/"
end

---@alias PackageKind "linter" | "formatter" | "lsp" | "dap"
---Register a package with the package manager
---@param kind PackageKind the kind of the package
---@param package string | table the name of the package
function mnvim.code.packages.install(kind, package)
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

mnvim.plugins.install({
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "jay-babu/mason-null-ls.nvim",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- Add packages to vim PATH
        vim.env.PATH = mnvim.code.packages.get_data_path() .. "bin:" .. vim.env.PATH

        -- Concat all packages
        local ensure_installed = require("mnvim.utils.tables").concat_lists(linters_packages, formatter_packages, lsp_packages, dap_packages)

        require("mason").setup({})
        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
            integrations = {
                ["mason-lspconfig"] = false, -- If true it cause an error
                ["mason-null-ls"] = true,
                ["mason-nvim-dap"] = true,
            },
        })
    end,
})
