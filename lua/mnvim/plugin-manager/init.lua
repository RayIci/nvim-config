local M = {}

-- Lazy path
M.lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Plugin list
M._plugins = {}

---Install and setup lazy nvim with the plugins
function M.setup()
    -- Check if lazy.nvim is installed
    -- If not, clone it from the repository
    -- and add it to the runtime path
    if not (vim.uv or vim.loop).fs_stat(M.lazy_path) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, M.lazy_path })

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
    vim.opt.rtp:prepend(M.lazy_path)

    require("lazy").setup({
        spec = M._plugins,
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

    -- Execute the registered events when plugins are loaded
    for _, func in pairs(M._on_plugins_loaded) do
        func()
    end
end

M._on_plugins_loaded = {}

---Register a function to be called when plugins are loaded
---@param function_callback function register a function that will be called when plugins are loaded
function M.on_plugins_loaded(function_callback)
    table.insert(M._on_plugins_loaded, function_callback)
end

---Register a plugin with lazy.nvim
---@param plugin table the plugin to be registered
function M.register(plugin)
    if plugin == nil or plugin == {} then
        return
    end

    table.insert(M._plugins, plugin)
end

---Register a module of plugin with lazy.nvim
---@param module string the lua plugin module with the lua folder structure (like "code.plugins")
function M.register_module(module)
    table.insert(M._plugins, { import = module })
end

---Register a custom plugin with lazy.nvim
---Example:
---
---register_custom("~/.config/nvim/custom-plugins/python-df.nvim", function() require "python-df".setup() end)
---@param direcotry string the directory of the plugin
---@param config_funciton function the function to be called when the plugin is loaded
function M.register_custom(direcotry, config_funciton)
    table.insert(M._plugins, { import = direcotry, config = config_funciton })
end

_G.mnvim.plugins = M
