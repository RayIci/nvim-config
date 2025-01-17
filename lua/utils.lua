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

function M.mason_data_path()
    return vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
end

function M.is_windows()
    return vim.loop.os_uname().sysname == "Windows_NT"
end

function M.print_table(table)
    vim.print(vim.inspect(table))
end

function M.toggle_nvim_background()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end

function M.concat_tables(t1, t2)
    local result = {}
    for _, v in ipairs(t1) do
        table.insert(result, v)
    end
    for _, v in ipairs(t2) do
        table.insert(result, v)
    end

    return result
end

function M.scandir(directory)
    local files = {}
    local handle = vim.loop.fs_scandir(directory)
    if handle then
        while true do
            local name, file_type = vim.loop.fs_scandir_next(handle)
            if not name then break end
            table.insert(files, name)
        end
    else
        print("Directory non trovata:", directory)
    end
    return files
end

return M
