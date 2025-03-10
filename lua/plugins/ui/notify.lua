local M = {
    "rcarriga/nvim-notify",
}

function M.config()
    require "notify".setup {
        stages = "fade_in_slide_out",
        timeout = 200,
        top_down = false,
        render = "default",
        max_width = 50,
        max_height = 10,
    }

    vim.notify = require "notify"
    M.keymaps()
end

function M.keymaps()
    require "which-key".add {
        { "<leader>n",  group = "Notifications" },
        { "<leader>nf", "<cmd>Telescope notify<cr>",     desc = "Show notifications" },
        { "<leader>xk", require("notify").dismiss,       desc = "Kill/Dismiss notifications" },
        { "<leader>nh", require("notify").clear_history, desc = "Clear history" },
    }
end

return M
