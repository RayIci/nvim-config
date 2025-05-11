local M = {}

local lualine_c = {}
local lualine_x = {}

function M.config()
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
end

-- Inserts a component in lualine_c at left section
function M.insert_left(component)
    table.insert(lualine_c, component)
end

-- Inserts a component in lualine_x at right section
function M.insert_right(component)
    table.insert(lualine_x, component)
end

return M

-- require("lualine").setup({
--     options = {
--         icons_enabled = true,
--         theme = "auto",
--         component_separators = { right = icons.ui.LineMiddle, left = icons.ui.LineMiddle },
--         section_separators = { right = icons.ui.BoldDividerLeftCircle, left = icons.ui.BoldDividerRightCircle },
--         disabled_filetypes = {
--             statusline = {},
--             winbar = {},
--         },
--         ignore_focus = {},
--         always_divide_middle = true,
--         always_show_tabline = true,
--         globalstatus = false,
--         refresh = {
--             statusline = 100,
--             tabline = 100,
--             winbar = 100,
--         },
--     },
--     sections = {
--         lualine_a = { "mode" },
--         lualine_b = { "branch", "diff", "diagnostics" },
--         lualine_c = {
--             { "macro_recording", "%S" },
--             "filename",
--         },
--         lualine_x = {
--             {
--                 function()
--                     local venv = os.getenv("VIRTUAL_ENV")
--                     return venv and "(" .. icons.code.python .. " " .. vim.fn.fnamemodify(venv, ":t") .. ")" or ""
--                 end,
--             },
--         },
--         lualine_y = {
--             "encoding",
--             "fileformat",
--             "filetype",
--             {
--                 function()
--                     return "Current tab: " .. tostring(vim.fn.tabpagenr()) .. "/" .. tostring(vim.fn.tabpagenr("$"))
--                 end,
--             },
--             "progress",
--         },
--         lualine_z = { "location" },
--     },
--     inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = { "filename" },
--         lualine_x = { "location" },
--         lualine_y = {},
--         lualine_z = {},
--     },
--     tabline = {},
--     winbar = {},
--     inactive_winbar = {},
--     extensions = {},
-- })
