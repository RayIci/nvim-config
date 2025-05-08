mnvim.plugins.register_module("mnvim.keymaps.plugins")

local M = {}

local which_key = require("mnvim.keymaps.which-key")
local default_keymaps_opts = {
    noremap = true,
    silent = true,
}

---Map a key to a functionality
---@param mode KeymapModality The mode in which the keymap should be active. Can be a single mode or an array of modes.
---@param key string The key to be mapped.
---@param functionalty string | function The functionality to be executed when the key is pressed.
---@param opts table Optional additional options for the keymap.
function M.map(mode, key, functionalty, opts)
    if key == nil then
        error("Key is required for the keymap")
    end

    opts = opts or {}
    mode = mode or "n"
    vim.keymap.set(mode, key, functionalty, vim.tbl_deep_extend("force", default_keymaps_opts, opts))
end

---Create a group of keymaps, It does not add a functionality to the keymap but add the name
---for the group of keymaps.
---@param keygroup string The key used for the group.
---@param desc string The description of the group, this will be the one diplayed.
---@param mode KeymapModality | nil The mode in which the keymap should be active. Can be a single mode or an array of modes. (default is "n")
M.map_group = function (keygroup, desc, mode)
    which_key.add_keygroup(keygroup, desc, mode)
end

_G.mnvim.keymaps = M
