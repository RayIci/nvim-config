mnvim.plugins.install({
    "andrew-george/telescope-themes",
})

mnvim.telescope.extensions_add("themes", {
    enable_previewer = true,
    enable_live_preview = true,
    persist = {
        enabled = true,
        path = vim.fn.stdpath("config") .. "/lua/mnvim/colorscheme.lua",
    },
})

mnvim.themes.actions.select = function()
    vim.cmd("Telescope themes")
end
