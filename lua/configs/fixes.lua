-- Those are needed by lualine so that we always have ONE lualine
-- even if we have multiple split opened.
vim.o.laststatus = 3
vim.o.cmdheight = 0
-- Also it needs to be set every time the colorscheme changes
-- But after the colorscheme has been set
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- So we defear a bit making sure that the colorscheme has been applied
        vim.defer_fn(function()
            vim.o.laststatus = 3
            vim.o.cmdheight = 0
            require("configs.highlight").set_highlight()
        end, 200)
    end,
})
