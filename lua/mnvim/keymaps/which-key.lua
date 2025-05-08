local M = {}

local keymaps_add = {}

---@alias Modality "n" | "i" | "v" | "x" | "t"
---@alias KeymapModality Modality | Modality[]

---Create a group of keymaps, It does not add a functionality to the keymap but add the name
---for the group of keymaps.
---@param keygroup string The key used for the group.
---@param desc string The description of the group, this will be the one diplayed.
---@param mode KeymapModality | nil The mode in which the keymap should be active. Can be a single mode or an array of modes. (default is "n")
function M.add_keygroup(keygroup, desc, mode)
    if desc == nil then
        error("Description is required for the keymap group")
    end
    if keygroup == nil then
        error("Keygroup is required for the keymap group")
    end

    mode = mode or "n"
    table.insert(keymaps_add, { keygroup, group = desc, mode = mode })
end

function M.config()
    local which_key = require("which-key")
    which_key.setup({
        preset = "helix",
    })
    which_key.add(keymaps_add)
end

return M
