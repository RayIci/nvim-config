local M = {}

function M.mason_data_path()
    return vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
end

function M.mason_bins_path()
    return M.mason_data_path() .. "/bin/"
end

return M
