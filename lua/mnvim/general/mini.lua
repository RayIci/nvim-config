mnvim.plugins.install({
    { "echasnovski/mini.nvim", version = false },
    {
        "echasnovski/mini.splitjoin",
        config = function()
            local miniSplitJoin = require("mini.splitjoin")
            miniSplitJoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })
            vim.keymap.set({ "n", "x", "v" }, "sj", function()
                miniSplitJoin.join()
            end, { desc = "Join arguments" })
            vim.keymap.set({ "n", "x", "v" }, "sk", function()
                miniSplitJoin.split()
            end, { desc = "Split arguments" })
        end,
    },
})
