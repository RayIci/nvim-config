local M = {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        "luukvbaal/statuscol.nvim",
    },
}


function M.config()
    -- Disable the folcolumn color

    local builtin = require "statuscol.builtin"
    local cfg = {
        ft_ignore = { 'neo-tree', "neotree" },
        setopt = true,
        relculright = true,
        segments = {
            { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
            { text = { "%s" },                  click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
    }

    require("statuscol").setup(cfg)

    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    require("ufo").setup {
        close_fold_kinds_for_ft = {},
        close_fold_kinds = {},
        open_fold_hl_timeout = 10,
        enable_get_fold_virt_text = true,
        provider_selector = function(_, _, _)
            return { "treesitter", "indent" }
        end,

        preview = {
            win_config = {
                border = { "", "─", "", "", "", "─", "", "" },
                winhighlight = "Normal:Folded",
                winblend = 0,
            },
            mappings = {
                scrollU = "<C-k>",
                scrollD = "<C-j>",
                jumpTop = "[",
                jumpBot = "]",
            },
        },
    }
end

return M
