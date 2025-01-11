local M = {}

M.dopts = {
    noremap = true,
    silent = true,
}

function M.keymap(mode, key, functionalty, opts)
    opts = opts or {}
    mode = mode or "n"
    vim.keymap.set(mode, key, functionalty, vim.tbl_deep_extend("force", M.dopts, opts))
end

return M
