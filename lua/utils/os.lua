local M = {}

function M.is_windows()
    return vim.loop.os_uname().sysname == "Windows_NT"
end

function M.scandir(directory)
    local files = {}
    local handle = vim.loop.fs_scandir(directory)
    if handle then
        while true do
            local name, file_type = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            table.insert(files, name)
        end
    else
        error("Directory " .. directory .. " not found")
    end
    return files
end

return M
