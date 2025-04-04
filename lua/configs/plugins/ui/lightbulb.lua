require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
    sign = {
        enabled = false,
    },

    -- 2. Virtual text.
    virtual_text = {
        text = require("utils.icons").diagnostics.BoldHint,
        lens_text = "🔎",
        enabled = true,
    },
})
