local M = {
    "kosayoda/nvim-lightbulb",
}

function M.config()
    require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
        sign = {
            enabled = false,
        },

        -- 2. Virtual text.
        virtual_text = {
            enabled = true,
        },
    })
end

return M
