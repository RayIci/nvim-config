_G.mnvim = {}

-- Require the initial functionalities 
-- Do not change the order of the plugins require
require("mnvim.plugin-manager")
require("mnvim.keymaps")
require("mnvim.utils")
require("mnvim.ui")

require("mnvim.explorer")


_G.mnvim.setup = function()
    -- Setup the plugins by starting the registered ones
    mnvim.plugins.setup()
end
