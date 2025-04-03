local icons = require("utils.icons")
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { right = icons.ui.BoldLineMiddle, left = icons.ui.BoldLineMiddle },
        section_separators = { right = icons.ui.BoldDividerLeftCircle, left = icons.ui.BoldDividerRightCircle },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            { "macro_recording", "%S" },
            "filename",
        },
        lualine_x = {
            {
                function()
                    local venv = os.getenv("VIRTUAL_ENV")
                    return venv and "(" .. icons.code.python .. " " .. vim.fn.fnamemodify(venv, ":t") .. ")" or ""
                end,
            },
        },
        lualine_y = {
            "encoding",
            "fileformat",
            "filetype",
            {
                function()
                    return "Current tab: " .. tostring(vim.fn.tabpagenr()) .. "/" .. tostring(vim.fn.tabpagenr("$"))
                end,
            },
            "progress",
        },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
})

vim.o.laststatus = 3
-- vim.o.cmdheight = 0
