local M = {}

local linter_configurations = {}
---Configure the default setups for a linter
---@param linter string linter name
---@param opts table
function M.configure_linter(linter, opts)
    if opts == {} then
        return
    end
    linter_configurations[linter] = opts
end

local linter_by_ft = {}
---Register a linter or multiple one for a filetype
---@param filetype string The filetype where the linter will be registered for
---@param linter string|string[] The linter or list of linters
---@param opts table|nil Other options
function M.register_for_filetype(filetype, linter, opts)
    opts = opts or {}

    if type(linter) == "string" then
        linter = { linter }
    end

    if linter_by_ft[filetype] == nil then
        linter_by_ft[filetype] = {}
    end

    linter_by_ft[filetype] = require('mnvim.utils.tables').concat_lists(
        linter_by_ft[filetype],
        linter,
        opts
    )
end

function M.config()
    local lint = require("lint")

    for linter, opts in pairs(linter_configurations) do
        vim.tbl_deep_extend("force", lint.linters[linter], opts)
    end

    lint.linters_by_ft = linter_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        callback = function ()
            -- try_lint without arguments runs the linters defined in `linters_by_ft`
            -- for the current filetype
            require("lint").try_lint()
        end,
    })
end

return M
