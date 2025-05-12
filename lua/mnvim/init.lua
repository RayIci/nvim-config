_G.mnvim = {}

-- Require the initial functionalities
-- Do not change the order of the plugins require

-- Initialize the plugins manager used to register plugins into
-- in the backend it uses lazy to handle the plugins
local plugin_manager = require("mnvim.lazy")

require("mnvim.keymaps")
require("mnvim.telescope")
require("mnvim.ui")
require("mnvim.explorer")
require("mnvim.code")
require("mnvim.session")
require("mnvim.buffers")

-- Add Diagnostics functionalities
local diagnostics = require("mnvim.diagnostics")

-- The setup function used to run mnvim
_G.mnvim.setup = function()
    plugin_manager.install_plugins()
    diagnostics.config()
end
