mnvim.plugins.register_module("mnvim.explorer.plugins")

local M = {}

M.filtered_items = {}
---@type string[]
M.filtered_items.hide_by_name = {}
---@type string[]
M.filtered_items.hide_by_pattern = {}
---@type string[]
M.filtered_items.always_show = {}
---@type string[]
M.filtered_items.never_show = {}
---@type string[]
M.filtered_items.never_show_by_pattern = {}


M.window = {}
---@alias Position "left" | "right"
---@type Position default explorer position
M.window.position = "left"
--- @type integer default explorer width 
M.window.width = 60

M.indent = {}
--- @type integer default indent size
M.indent.size = 3

M.icons = {}
M.icons.folder_closed = mnvim.ui.icons.ui.ChevronShortRight
M.icons.folder_open = mnvim.ui.icons.ui.ChevronShortDown
M.icons.folder_empty = mnvim.ui.icons.ui.ChevronShortDown

-----------------------------------------------
-- Explorer Functionalities 
-----------------------------------------------

M.actions = {}
M.actions.open_explorer = function ()
    vim.cmd("Neotree toggle") 
end

M.actions.open_buffer_explorer = function ()
    vim.cmd("Neotree buffers position=float") 
end

M.actions.open_git_explorer = function ()
    vim.cmd("Neotree git_status position=float") 
end

_G.mnvim.explorer = M
