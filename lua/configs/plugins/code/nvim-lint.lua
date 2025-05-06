local register_package = require("configs.mason").register_package
register_package("diagnostic", "hadolint")
register_package("diagnostic", "sqlfluff")
register_package("diagnostic", "flake8")
-- register_package("diagnostic", "eslint_d")

local lint = require("lint")

-- Setup configurations for linters
local mason_bin_path = require("configs.mason").mason_bin_path()
lint.linters.flake8.cmd = mason_bin_path .. "flake8"
lint.linters.sqlfluff.args = {
    "--dialect",
    "postgres",
    "--exclude-rules",
    "layout.indent,layout.cte_bracket,layout.select_targets,layout.spacing",
}

-- Setup lint for filetypes
-- use `:= vim.bo.filetype` to understand the file type
lint.linters_by_ft = {
    -- python = { "flake8" },
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
    dockerfile = { "hadolint" },
    sql = { "sqlfluff" },
}

-- Lint autocmd
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
    end,
})
