mnvim.plugins.register_module("mnvim.ui.plugins")

_G.mnvim.ui = {}
_G.mnvim.ui.icons = require("mnvim.ui.icons")

--------------------------------------------------------------------
--- Statusline
--------------------------------------------------------------------
_G.mnvim.ui.statusline = {}
local lualine = require("mnvim.ui.lualine")

---Insert a component on the left side of statusline
---@param component table The component to be insterted
mnvim.ui.statusline.insert_left = function (component)
    lualine.insert_left(component)
end

---Insert a component on the right side of statusline
---@param component table The component to be insterted
mnvim.ui.statusline.insert_right = function (component)
    lualine.insert_right(component)
end

----------------------------------------------------------------------
--- Indent Blankline
----------------------------------------------------------------------
_G.mnvim.ui.indentation = {}

-- Those are needed by lualine so that we always have ONE lualine
-- even if we have multiple split opened.
vim.o.laststatus = 3
vim.o.cmdheight = 0

---@type string char used as indent chart
mnvim.ui.indentation.indent_char = mnvim.ui.icons.ui.LineDashedIndent
---@type string[] list of filetypes to exclude
mnvim.ui.indentation.exclude_filetypes = {}

-----------------------------------------------------------------------
--- Bufferline
-----------------------------------------------------------------------
_G.mnvim.ui.buffers = {}
_G.mnvim.ui.buffers.actions = {}

---@class BuffersIcons
---@field modified string icon for modified buffer
---@field close string icon for close buffer
---@field pin string icon for pinned buffer

---@type BuffersIcons icons
mnvim.ui.buffers.icons = {
    modified = mnvim.ui.icons.ui.Dot,
    close = mnvim.ui.icons.ui.Close,
    pin = mnvim.ui.icons.ui.Pin,
}

local bufferline = require("mnvim.ui.bufferline")
mnvim.ui.buffers.actions.new = bufferline.new
mnvim.ui.buffers.actions.close = bufferline.close
mnvim.ui.buffers.actions.close_all = bufferline.close_all
mnvim.ui.buffers.actions.close_force = bufferline.close_force
mnvim.ui.buffers.actions.close_all_force = bufferline.close_all_force
mnvim.ui.buffers.actions.close_all_but_this_one = bufferline.close_all_but_this_one
mnvim.ui.buffers.actions.move_next = bufferline.move_next
mnvim.ui.buffers.actions.move_previous = bufferline.move_previous
mnvim.ui.buffers.actions.next = bufferline.next
mnvim.ui.buffers.actions.previous = bufferline.previous
mnvim.ui.buffers.actions.pin_toggle = bufferline.pin_toggle
