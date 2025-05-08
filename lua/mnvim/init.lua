_G.mnvim = {}

-- Require the initial functionalities 
-- Do not change the order of the plugins require

-- Initialize the event manager used to handle mnvim events 
local event_manager = require("mnvim.event-manager")
-- Initialize the plugins manager used to register plugins into
-- in the backend it uses lazy to handle the plugins
local plugin_manager = require("mnvim.plugin-manager")

-- Initialize keymaps functionalities 
require("mnvim.keymaps")

-- Add UI
require("mnvim.ui")

-- Add Explorer
require("mnvim.explorer")

-- Add Coding functionalities
require("mnvim.code")

-- The setup function used to run mnvim 
_G.mnvim.setup = function()
    plugin_manager.install_plugins()
end
