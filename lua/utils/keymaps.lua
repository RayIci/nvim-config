local M = {}

M.default_keymaps_opts = {
    noremap = true,
    silent = true,
}

function M.map(mode, key, functionalty, opts)
    opts = opts or {}
    mode = mode or "n"
    vim.keymap.set(mode, key, functionalty, vim.tbl_deep_extend("force", M.default_keymaps_opts, opts))
end

return M
