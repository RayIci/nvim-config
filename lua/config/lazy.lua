local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "code" },
        { import = "code.extra" },
        { import = "themes" },
        { import = "git" },
        { import = "misc" },
        { import = "ui" },
        -- Custom plugin import
        -- {
        --     dir = "~/.config/nvim/custom-plugins/python-df.nvim",
        --     config = function()
        --         require "python-df".setup()
        --     end
        -- }
    },
    defaults = {
        lazy = false,
    },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
