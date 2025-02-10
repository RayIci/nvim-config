local M = {
    'rmagatti/auto-session',
    lazy = false
}

function M.config()
    require "auto-session".setup {
        session_lens = {
            -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
            load_on_setup = true,
            previewer = false,
            theme_conf = { border = true },
        }
    }
end

return M
