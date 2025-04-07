local M = {}

local sethl = vim.api.nvim_set_hl

function M.set_highlight()
    vim.opt.termguicolors = true

    -- Colorscheme fix, reset background
    vim.cmd("highlight FoldColumn guibg=NONE guifg=NONE")
    vim.cmd("highlight SignColumn guibg=NONE guifg=NONE")
    vim.cmd("highlight CursorLineNr guibg=NONE guifg=NONE")
    -- vim.cmd("highlight LineNr guifg=#5eacd3 guibg=NONE") -- Line number color

    -- DAP brakepoint and others
    sethl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" })
    sethl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    sethl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

    -- Colors highlight for gitsigns
    sethl(0, "GitSignsAdd", { fg = "#00ff00", bg = "none" })
    sethl(0, "GitSignsChange", { fg = "#ffff00", bg = "none" })
    sethl(0, "GitSignsDelete", { fg = "#ff0000", bg = "none" })
    sethl(0, "GitSignsStagedAdd", { fg = "#004400", bg = "none" })
    sethl(0, "GitSignsStagedChange", { fg = "#444400", bg = "none" })
    sethl(0, "GitSignsStagedDelete", { fg = "#440000", bg = "none" })

    if vim.o.background == "dark" then
        vim.cmd("highlight Cursor ctermfg=white guifg=#888888 guibg=#aaaaaa")
    else
        vim.cmd("highlight Cursor ctermfg=black guifg=#aaaaaa guibg=#888888")
    end

    -- Diagnostics highlight
    vim.cmd.highlight("DiagnosticUnderlineError guisp=#ff0000 gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineWarn guisp=#FFA500 gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineInfo guisp=#00FFFF gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineHint guisp=#00FF00 gui=undercurl")
end

M.set_highlight()

return M
