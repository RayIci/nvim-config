_G.mnvim.keymaps = {}

local keymaps_add = {}

---@alias Modality "n" | "i" | "v" | "x" | "t"
---@alias KeymapModality Modality | Modality[]

---Create a group of keymaps, It does not add a functionality to the keymap but add the name
---for the group of keymaps.
---@param keygroup string The key used for the group.
---@param desc string The description of the group, this will be the one diplayed.
---@param mode KeymapModality | nil The mode in which the keymap should be active. Can be a single mode or an array of modes. (default is "n")
function mnvim.keymaps.map_group(keygroup, desc, mode)
    if desc == nil then
        error("Description is required for the keymap group")
    end
    if keygroup == nil then
        error("Keygroup is required for the keymap group")
    end

    mode = mode or "n"
    table.insert(keymaps_add, { keygroup, group = desc, mode = mode })
end

local default_keymaps_opts = {
    noremap = true,
    silent = true,
}

---Map a key to a functionality
---@param mode KeymapModality The mode in which the keymap should be active. Can be a single mode or an array of modes.
---@param key string The key to be mapped.
---@param functionalty string | function The functionality to be executed when the key is pressed.
---@param opts table Optional additional options for the keymap.
function mnvim.keymaps.map(mode, key, functionalty, opts)
    if key == nil then
        error("Key is required for the keymap")
    end

    opts = opts or {}
    mode = mode or "n"
    vim.keymap.set(mode, key, functionalty, vim.tbl_deep_extend("force", default_keymaps_opts, opts))
end

mnvim.plugins.install({
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        local which_key = require("which-key")
        which_key.setup({
            preset = "helix",
        })
        which_key.add(keymaps_add)
    end,
})
