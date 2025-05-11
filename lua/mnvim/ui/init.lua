mnvim.plugins.register_module("mnvim.ui.plugins")

_G.mnvim.ui = {}
_G.mnvim.ui.icons = require("mnvim.ui.icons")

_G.mnvim.ui.statusline = {}
local lualine = require("mnvim.ui.lualine")

---Insert a component on the left side of statusline
---@param component table The component to be insterted
mnvim.ui.statusline.insert_left = function(component)
    lualine.insert_left(component)
end

---Insert a component on the right side of statusline
---@param component table The component to be insterted
mnvim.ui.statusline.insert_right = function(component)
    lualine.insert_right(component)
end

-- Those are needed by lualine so that we always have ONE lualine
-- even if we have multiple split opened.
vim.o.laststatus = 3
vim.o.cmdheight = 0

_G.mnvim.ui.indentation = {}

---@type string char used as indent chart
mnvim.ui.indentation.indent_char = mnvim.ui.icons.ui.LineDashedIndent
---@type string[] list of filetypes to exclude
mnvim.ui.indentation.exclude_filetypes = {}

local indent_blankline = require("mnvim.ui.indent-blankline")
