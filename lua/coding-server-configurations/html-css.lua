mnvim.code.packages.install("lsp", "css-lsp")
mnvim.code.lsp.register("cssls")

mnvim.code.packages.install("lsp", "tailwindcss-language-server")
mnvim.code.lsp.register("tailwindcss")

mnvim.plugins.install({
    -- press _ on visual to sorround with html tag
    -- Type ("_" is the cursor position)
    -- Then type <c-y>, (Ctrl+y+,) and you should see:
    { "mattn/emmet-vim" },
    -- Auto close
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = true,
                },
            })
        end,
    },
})
