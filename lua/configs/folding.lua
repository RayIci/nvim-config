vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.viewoptions:append("folds")

-- vim.opt.foldmethod = "indent" -- manual | indent | expr | syntax | diff | marker
-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
