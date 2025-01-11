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
}


function M.config()
    -- Mason default setup
    require("mason").setup {
        ui = {
            border = "rounded",
        }
    }

    -- Mason LSP
    require("mason-lspconfig").setup {
        automatic_installation = true,
        ensure_installed = M.lsp_servers,
    }
end

return M
