-- Add functionalities to the global variable
_G.mnvim.keymaps = require("mnvim.keymaps.keymaps")

-- Register the plugins needed by the utils module
mnvim.plugins.register_module("mnvim.keymaps.plugins")
