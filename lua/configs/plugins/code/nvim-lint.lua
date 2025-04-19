-- Install linters from mason package manager using a tool for ensure installed
local mason_packages = {
    "flake8",
}

-- TODO: Make mason install packages a general configuration
-- meaning -> abstract all amson ensure_isntalled also for other plugins
require("mason-tool-installer").setup({
    ensure_installed = mason_packages,
    run_on_start = true,
    integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
    },
})

local lint = require("lint")

-- Setup configurations for linters
local mason_bin_path = require("utils.mason").mason_bin_path()
lint.linters.flake8.cmd = mason_bin_path .. "flake8"

-- Setup lint for filetypes
-- use `:= vim.bo.filetype` to understand the file type
lint.linters_by_ft = {
    python = { "flake8" },
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
}

-- Lint autocmd
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
    end,
})
