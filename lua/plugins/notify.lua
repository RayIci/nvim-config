local M = {
    "rcarriga/nvim-notify",
}
function M.config()
    require "notify".setup {
        stages = "fade_in_slide_out",
        timeout = 200,
        top_down = false,
        render = "default",
        -- max_width = 50,
        -- max_height = 10,
    }

    vim.notify = require "notify"
end

return M
