local M = {}

function M.is_windows()
    return vim.loop.os_uname().sysname == "Windows_NT"
end

return M
