-- Leader map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup options
require "config.options"

-- Setup lazy package manager
require "config.lazy"

-- Setup keymaps
require "config.keymaps"

-- Setup Diagnostics
require "config.diagnostics"

-- Autocommands
require "config.autocmd"

-- Fixes:
-- Colorscheme fix, reset background
vim.cmd("highlight FoldColumn guibg=NONE guifg=NONE")
vim.cmd("highlight SignColumn guibg=NONE guifg=NONE")
vim.cmd("highlight CursorLineNr guibg=NONE guifg=NONE")
-- vim.cmd("highlight LineNr guifg=#5eacd3 guibg=NONE") -- Line number color
