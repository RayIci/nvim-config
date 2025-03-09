-- Leader map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup options
require "core.options"

-- Setup lazy package manager
require "core.lazy"

-- Setup keymaps
require "core.keymaps"

-- Setup diagnostics
require "core.diagnostics"

-- Setup highlights
require "core.highlight"
