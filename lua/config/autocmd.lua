-- Disable ufo for certaint files
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "nvcheatsheet", "neo-tree" },
--     callback = function()
--         require("ufo").detach()
--         vim.o.foldenable = false
--         vim.o.foldcolumn = '0'
--     end
-- })


-- Intercept quickfix and use trouble quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    callback = function()
        vim.cmd([[Trouble qflist open]])
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "quickfix" then
            vim.schedule(function()
                vim.cmd([[cclose]])
                vim.cmd([[Trouble qflist open]])
            end)
        end
    end,
})
