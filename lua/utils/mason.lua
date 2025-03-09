local M = {}

function M.mason_data_path()
    return vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
end

return M
