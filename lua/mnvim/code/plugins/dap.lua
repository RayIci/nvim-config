-- Debug Adapter Protocol
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Virtual text
        "theHamsta/nvim-dap-virtual-text",

        -- Brakepoint persist
        "Weissle/persistent-breakpoints.nvim",

        -- Dap language specific packages
        "mfussenegger/nvim-dap-python",
        "NicholasMata/nvim-dap-cs",
    },
}
