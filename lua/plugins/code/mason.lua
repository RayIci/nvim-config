local M = {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    }
}

-- The lsp servers that mason have to install
-- Those servers are also used my lsp to configure
M.lsp_servers = {
    "pyright",                         -- Python
    "ts_ls",                           -- Typescript
    "tailwindcss",                     -- Tailwindcss
    "texlab",                          -- Latex
    "omnisharp",                       -- C#
    "clangd",                          -- C and C++
    "cmake",                           -- cmake
    "docker_compose_language_service", -- Docker compose
    "dockerls",                        -- Docker
    "lua_ls",                          -- Lua
    "sqlls",                           -- SQL
}

-- none-ls packages for diagnostics and formatting
M.none_ls_server_not_to_configure = {
    "eslint_d", -- ts/js linter
}

M.none_ls_servers_formatting = {
    "prettier",     -- ts/js formatter
    "shfmt",        -- Shell formatter
    "black",        -- Python formatter
    "isort",        -- Python import sorter
    "csharpier",    -- C# formatter
    "clang-format", -- C & C++ formatter
    "rustywind",    -- tailwind classes organizer
    "sqlfmt",       -- SQL formatter

}

M.none_ls_servers_diagnostics = {
    "hadolint", -- Dockerfile linter
    "sqlfluff", -- SQL linter
}

-- The dap servers that mason will install
M.dap_servers = {
    "python"
}


function M.config()
    -- Mason default setup
    require("mason").setup {
        -- ui = {
        --     border = "rounded",
        -- }
    }

    -- Mason LSP
    require "mason-lspconfig".setup {
        automatic_installation = true,
        ensure_installed = M.lsp_servers,
    }

    -- None ls for diagnostics and formatting
    require("mason-null-ls").setup({
        ensure_installed = vim.tbl_deep_extend("force",
            M.none_ls_servers_formatting,
            M.none_ls_servers_diagnostics,
            M.none_ls_server_not_to_configure
        ),
        automatic_installation = true,
    })

    -- Mason DAP
    require "mason-nvim-dap".setup {
        automatic_installation = true,
        ensure_installed = M.dap_servers,
    }
end

return M
