_G.mnvim.code = {}
local package_manager = require("mnvim.code.package-manager")

-- Install the code packages as soon as the plugins are installed
-- This is needed since the package manager is mason and then needs to be
-- firstly installed as a plugin by the plugins manager
mnvim.events.register("plugins-loaded", function()
    package_manager.install_packages()
end)
