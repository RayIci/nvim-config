local M = {
    "mfussenegger/nvim-dap",
    dependencies = {

        -- Dap language specific packages
        "mfussenegger/nvim-dap-python",
    },
}

-- Mason data path
local mason_path = require "utils".mason_data_path()


-- Functions that setup the python dap adapter
function M.python_dap_configure()
    pcall(function()
        require "dap-python".setup(mason_path .. "packages/debugpy/venv/bin/python")
    end)
end

function M.config()
    -- DAP config function
    M.python_dap_configure()

end

return M
