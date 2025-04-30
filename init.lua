-- Leader map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- CORE OPTIONS --
-- This is needed do be executed as first since some
-- plugins redefine some vim options
require("core.options")

-- CONFIGURATIONS --
require("configs.lazy") -- Lazy package manager initialize all plugins
require("configs.plugins.configure") -- Some plugins needs to be configured not in config function of lazy
require("configs.autocmds")
require("configs.diagnostics")
require("configs.highlight")
require("configs.folding")
require("configs.mason").isntall_packages() -- Install all packages that are needed to be installed

-- CORE KEYMAPS --
-- This need to be executed after the lazy configurations
-- since the keymaps dependes on which-key plugin
require("core.keymaps")

-- FIXES --
-- Those ones are general fixes that runs at the end of everything
-- So i'm sure that are set at the end
require("configs.fixes")
