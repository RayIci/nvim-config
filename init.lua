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

-- Workaround to fix xclip
require "config.clipboard"

-- Autocommands
require "config.autocmd"
