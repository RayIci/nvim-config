_G.mnvim.code = {}

require("mnvim.code.mason")
require("mnvim.code.treesitter")
require("mnvim.code.lspconfig")
require("mnvim.code.nvim-lint")
require("mnvim.code.dap")
require("mnvim.code.conform")
require("mnvim.code.autocomplete")
require("mnvim.code.test")

--- Other useful plugins
mnvim.plugins.install({
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
})
