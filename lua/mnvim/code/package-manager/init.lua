mnvim.plugins.register_module("mnvim.code.package-manager.plugins")

-- Public method API table
local M = {}

-- Private method table
local P = {}

local mason = require("mnvim.code.package-manager.mason")

---Get the package manager data path
---@return string the path to the package manager
function M.get_data_path()
    return mason.get_mason_data_path()
end

---Get the package manager bin path
---@return string the path to the package manager bin
function M.get_bin_path()
    return mason.get_mason_bin_path()
end

---Register a package with the package manager
---@param kind PackageKind the kind of the package 
---@param package string | table the name of the package 
function M.install(kind, package)
    mason.register_package(kind, package)
end

---Install all packages with the package manager
function P.install_packages()
    mason.install_packages()
end

_G.mnvim.code.packages = M
return P
