return {
    -- Treesitter for syntax hilighting
    {
        "nvim-treesitter/nvim-treesitter",
        config = require("utils.configs").configure("code.treesitter"),
        build = ":TSUpdate",
        dependencies = {
            "LiadOz/nvim-dap-repl-highlights",
            "nvim-treesitter/nvim-treesitter-context",
        },
    },

    -- Mason to manage packages
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = true,
    },

    -- None ls for diagnostics and formatting
    {
        "nvimtools/none-ls.nvim",
        config = require("utils.configs").configure("code.none-ls"),
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
    },

    -- Cmp for autocompletition
    {
        "hrsh7th/nvim-cmp",
        config = require("utils.configs").configure("code.cmp"),
        dependencies = {
            -- other dependencies
            "neovim/nvim-lspconfig",
            "onsails/lspkind.nvim",

            -- cmp dependecies
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

            -- luasnip engine dependencies
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
        },
    },

    -- Lsp
    {
        "neovim/nvim-lspconfig",
        config = require("utils.configs").configure("code.lspconfig"),
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
    },

    -- Copilot
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        config = require("utils.configs").configure("code.copilot"),
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
    },

    -- DAP for debugging
    {
        "mfussenegger/nvim-dap",
        config = require("utils.configs").configure("code.dap"),
        dependencies = {
            -- Virtual text
            "theHamsta/nvim-dap-virtual-text",

            -- Brakepoint persist
            "Weissle/persistent-breakpoints.nvim",

            -- Dap language specific packages
            "mfussenegger/nvim-dap-python",
            "NicholasMata/nvim-dap-cs",
        },
    },

    -- Neotest for testing
    {
        "nvim-neotest/neotest",
        config = require("utils.configs").configure("code.neotest"),
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            -- Test language specific plugins
            "nvim-neotest/neotest-python",
        },
    },
}
