local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

mnvim.code.packages.install("lsp", "texlab")
mnvim.code.packages.install("formatter", "latexindent")

mnvim.code.lsp.register("texlab")
mnvim.code.formatters.register_for_filetype("tex", "latexindent")

mnvim.plugins.install({
    "lervag/vimtex",
    lazy = false,
    config = function()
        vim.g.vimtex_view_method = "general"

        -- Path to pdf viewer
        vim.g.vimtex_view_general_viewer = "/mnt/c/Users/Alex/AppData/Local/SumatraPDF/SumatraPDF.exe"
    end,
})

mapgroup("-l", "Latex")
map("n", "-lc", "<cmd>VimtexCompile<cr>", { desc = "Compile" })
map("n", "-lv", "<cmd>VimtexView<cr>", { desc = "View" })
map("n", "-ls", "<cmd>VimtexStop<cr>", { desc = "Stop" })
map("n", "-lk", "<cmd>VimtexKill<cr>", { desc = "Kill" })
map("n", "-ll", "<cmd>VimtexLog<cr>", { desc = "Logs" })
