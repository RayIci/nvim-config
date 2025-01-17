local M = {
    "zaldih/themery.nvim",
    lazy = false,
}

function M.config()
    -- Table of the possible themes to switch
    local list_themes = {}

    local files = require "utils".scandir(vim.fn.getcwd() .. "/lua/themes/all")

    for _, file in ipairs(files) do
        if file:match("%.lua$") then
            local theme_module = file:gsub("%.lua$", "")
            local ok, module = pcall(require, "themes.all." .. theme_module)

            if ok and module.themes ~= nil then
                list_themes = require "utils".concat_tables(list_themes, module.themes)
            end
        end
    end

    require("themery").setup({
        themes = list_themes,
        livePreview = true,
    })
end

return M
