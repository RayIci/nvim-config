-- Treesitter for syntax hilighting
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "LiadOz/nvim-dap-repl-highlights",
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = require("mnvim.code.treesitter").config 
}
