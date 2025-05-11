vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("mnvim")

-- Setup coding
require("coding-server-configurations")
require("statusline")

mnvim.setup()

require("options")
require("keymaps")
