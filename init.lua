vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("mnvim")

-- Setup coding
require("configurations")
require("coding-server-configurations")
require("statusline")
require("plugins")
require("theme")

mnvim.setup()

require("options")
require("keymaps")
