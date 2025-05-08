return {
    {
        -- Mason to manage packages
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
    }
}
