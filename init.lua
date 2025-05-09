vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("mnvim")

-- Setup coding 
require("coding-server-configurations")

mnvim.setup()

require("options")
require("keymaps")
