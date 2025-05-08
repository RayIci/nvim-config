vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("mnvim")

require("options")
require("keymaps")

-- Setup coding 
require("coding-server-configurations")

mnvim.setup()
