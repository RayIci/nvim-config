_G.mnvim.statusline = {}

-- Those are needed by lualine so that we always have ONE lualine
-- even if we have multiple split opened.
vim.o.laststatus = 3
-- vim.o.cmdheight = 0  this line needs to be disabled since if
--                      you enable it moving block of lines doesnt work

local lualine_c = {}
local lualine_x = {}

mnvim.plugins.install({
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "yavorski/lualine-macro-recording.nvim" },
    },
    config = function()
        require("lualine").setup({
            options = {
                -- Disable sections and component separators
                component_separators = "",
                section_separators = "",
                theme = "auto",
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = lualine_c,
                lualine_x = lualine_x,
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        })
    end,
})

---Insert a component on the left side of statusline
---@param component table The component to be insterted
function mnvim.statusline.insert_left(component)
    table.insert(lualine_c, component)
end

---Insert a component on the right side of statusline
---@param component table The component to be insterted
function mnvim.statusline.insert_right(component)
    table.insert(lualine_x, component)
end
