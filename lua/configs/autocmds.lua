-- Intercept quickfix and use trouble quickfix
vim.api.nvim_create_user_command("Copen", "Trouble qflist toggle", {})
vim.api.nvim_create_user_command("Lopen", "Trouble loclist toggle", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(args)
        local bufnr = args.buf
        vim.defer_fn(function()
            local winid = vim.fn.bufwinid(bufnr)
            if winid == -1 then
                return
            end
            vim.api.nvim_win_close(winid, true)
            -- require("trouble").open("quickfix")
            vim.cmd("Copen")
        end, 0)
    end,
})
