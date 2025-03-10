vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nvcheatsheet", "neo-tree" },
    callback = function()
        require("ufo").detach()
        vim.o.foldenable = false
        vim.o.foldcolumn = '0'
    end
})
