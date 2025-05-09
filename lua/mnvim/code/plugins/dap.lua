-- Debug Adapter Protocol
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Virtual text
        "theHamsta/nvim-dap-virtual-text",

        -- Brakepoint persist
        -- "Weissle/persistent-breakpoints.nvim",
    },
    config = require("mnvim.code.dap").config
}
