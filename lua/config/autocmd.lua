vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nvcheatsheet", "neo-tree" },
    callback = function()
        require("ufo").detach()
        vim.opt_local.foldenable = false
        vim.opt_local.foldcolumn = '0'
    end
})
