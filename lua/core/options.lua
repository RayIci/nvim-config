vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.o.autoindent = true                         -- automatically indent
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.smartindent = false                     -- make indenting smarter again

vim.o.number = true                             -- activate ruler numbers
vim.o.relativenumber = true                     -- make ruler numbers relative

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

vim.opt.wrap = false                            -- display lines as one long line
vim.o.linebreak = true                          -- linewrap behaviour

vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim

vim.o.updatetime = 250                          -- Decrease update time (default: 4000)
vim.o.timeoutlen = 100                          -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)

vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case
vim.o.scrolloff = 8                             -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 8                         -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.o.whichwrap =
"bs<>[]hl"                                      -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.swapfile = false                          -- Creates a swapfile (default: true)
vim.opt.showtabline = 1                         -- Always show tabs (default: 1)vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.backup = false                          -- creates a backup file
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.pumblend = 10
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 100                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false

vim.opt.signcolumn =
"yes"                                                 -- always show the sign column, otherwise it would shift the text each time
vim.opt.title = true
vim.opt.titlelen = 0                                  -- do not shorten title
vim.opt.shortmess:append("c")                         -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:append("-")                         -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
