-- Leader map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- CORE OPTIONS --
-- This is needed do be executed as first since some
-- plugins redefine some vim options
require("core.options")

-- CONFIGURATIONS --
require("configs.lazy") -- Lazy package manager initialize all plugins
require("configs.diagnostics")
require("configs.highlight")

-- CORE KEYMAPS --
-- This need to be executed after the lazy configurations
-- since the keymaps dependes on which-key plugin
require("core.keymaps")
