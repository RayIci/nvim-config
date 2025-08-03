local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local vscode = require("vscode")

-- PLUGINS ------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = true,
    },
    {
        "easymotion/vim-easymotion",
        config = function ()
            keymap("n", "<leader>ws", "<Plug>(easymotion-s2)", { desc = "Easymotion search" })
            keymap("n", "<leader>wS", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion search overwin" })
            keymap("n", "<leader>wf", "<Plug>(easymotion-bd-f)", { desc = "Find char on current line" })
            keymap("n", "<leader>ww", "<Plug>(easymotion-bd-w)", { desc = "Skip word" })
            keymap("n", "<leader>we", "<Plug>(easymotion-bd-e)", { desc = "Skip word end" })
            keymap("n", "<leader>wl", "<Plug>(easymotion-lineforward)", { desc = "End of line" })
            keymap("n", "<leader>wh", "<Plug>(easymotion-linebackward)", { desc = "Start of line" })
        end,
    },
    {
        "mg979/vim-visual-multi",
    }
})


vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- keep history of search patterns
vim.opt.history = 1000

-- Ignore case in search patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Smart case: if search pattern contains uppercase letters, case-sensitive search is used

-- Scroll half-page down and up centering
keymap('n', '<C-d>', '<Cmd>normal! <C-d>zz<CR>', opts)
keymap('n', '<C-u>', '<Cmd>normal! <C-u>zz<CR>', opts)

-- Paste without overwriting the default register
keymap('v', 'p', '"_dP', { noremap = true, silent = true })

-- Move lines up and down
keymap({ "v", "n" }, "J", function ()
    vscode.action("editor.action.moveLinesDownAction")
end, { desc = "Move line up" })
keymap({ "v", "n" }, "K", function ()
    vscode.action("editor.action.moveLinesUpAction")
end, { desc = "Move line down" })

-- Show hover
keymap('n', 'H', function ()
    vscode.action("editor.action.showHover")
end, { desc = "Show hover" })

-- Remove highlight after search
keymap('n', '<Esc>', ':nohlsearch<CR>', opts)
keymap('n', '<C-x>', ':nohlsearch<CR>', opts)

-- EDITOR MANAGEMENT ------------------------------------------------------------------
-- Switch between editor
keymap('n', '<Tab>', function ()
    vscode.action("workbench.action.nextEditor")
end, { noremap = true, silent = true })
keymap('n', '<S-Tab>', function ()
    vscode.action("workbench.action.previousEditor")
end, { noremap = true, silent = true })
-- Move editor left and right
keymap("n", "<C-Left>", function ()
    vscode.action("workbench.action.moveEditorLeftInGroup")
end, opts)
keymap("n", "<C-Right>", function ()
    vscode.action("workbench.action.moveEditorRightInGroup")
end, opts)
-- Pin editor
vim.keymap.set("n", "<leader>bp", function ()
    vscode.action("workbench.action.pinEditor")
end, { noremap = true, silent = true })
-- Close all editors
vim.keymap.set("n", "<leader>xa", function ()
    vscode.action("workbench.action.closeAllEditors")
end, { noremap = true, silent = true })
-- Close other editors
vim.keymap.set("n", "<leader>xA", function ()
    vscode.action("workbench.action.closeOtherEditors")
end, { noremap = true, silent = true })
-- Close editor
keymap('n', '<leader>xw', function ()
    vscode.action("workbench.action.closeActiveEditor")
end, opts)
-------------------------------------------------------------------------------------

-- Show vscode file picker
keymap('n', '<leader><leader>', function ()
    vscode.action("workbench.action.quickOpen")
end, opts)

-- Explorer
keymap('n', '<leader>e', function ()
    vscode.action("workbench.view.explorer")
end, opts)

-- skip folds
vim.cmd('nmap j gj')
vim.cmd('nmap k gk')


-- Diagnostics
keymap('n', ']d', function ()
    vscode.action("editor.action.marker.next")
end, opts)

keymap('n', '[d', function ()
    vscode.action("editor.action.marker.prev")
end, opts)

-- Rename
keymap('n', '<leader>lr', function ()
    vscode.action("editor.action.rename")
end, opts)
