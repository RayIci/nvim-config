-- Buffer pages
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye",
    },
    config = require("mnvim.ui.bufferline").config
}
