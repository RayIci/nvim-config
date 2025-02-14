local M = {
    "stevearc/resession.nvim",
    lazy = false,
    dependencies = {
        "tiagovla/scope.nvim",
        lazy = false,
        config = true,
    },
}

function M.config()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require "resession".setup {
        -- override default filter
        buf_filter = function(bufnr)
            local buftype = vim.bo[bufnr].buftype
            if buftype == 'help' then
                return true
            end
            if buftype ~= "" and buftype ~= "acwrite" then
                return false
            end
            if vim.api.nvim_buf_get_name(bufnr) == "" then
                return false
            end

            -- this is required, since the default filter skips nobuflisted buffers
            return true
        end,
        extensions = { scope = {} }, -- add scope.nvim extension
    }

    local resession = require "resession"
    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            -- Always save a special session named "last"
            resession.save("last")
        end,
    })
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            -- Only load the session if nvim was started with no args and without reading from stdin
            if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                -- Save these to a different directory, so our manual sessions don't get polluted
                resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
        end,
        nested = true,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end,
    })
    vim.api.nvim_create_autocmd('StdinReadPre', {
        callback = function()
            -- Store this for later
            vim.g.using_stdin = true
        end,
    })
end

return M
