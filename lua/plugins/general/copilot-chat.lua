local M = {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                            -- Only on MacOS or Linux
}

--- Sets up key mappings for the Copilot Chat plugin.
-- This function defines custom keybindings to interact with the features of the Copilot Chat plugin.
-- It ensures seamless integration and ease of use for the plugin's functionality.
function M.keymaps()
    local map = require "utils.keymaps".map
    require "which-key".add({ "<leader>C", group = "Copilot chat", mode = {"n", "v"} })
    map({"v", "n"}, "<leader>Cc", "<cmd>CopilotChatToggle<cr>", { desc = "Open chat toggle" })
    map({"v", "n"}, "<leader>Cs", "<cmd>CopilotChatStop<cr>", { desc = "Stop output" })
    map({"v", "n"}, "<leader>Cr", "<cmd>CopilotChatReset<cr>", { desc = "Reset output" })
    map({"v", "n"}, "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", { desc = "Show prompts" })
end

function M.config()
    require("CopilotChat").setup {
      mappings = {
        close = {
          normal = 'q',
          insert = '',
        },
      }
    }
    M.keymaps()
end

return M
