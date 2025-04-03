local map = require("utils.keymaps").map
require("which-key").add({ "<leader>C", group = "Copilot chat", mode = { "n", "v" } })
map({ "v", "n" }, "<leader>Cc", "<cmd>CopilotChatToggle<cr>", { desc = "Open chat toggle" })
map({ "v", "n" }, "<leader>Cs", "<cmd>CopilotChatStop<cr>", { desc = "Stop output" })
map({ "v", "n" }, "<leader>Cr", "<cmd>CopilotChatReset<cr>", { desc = "Reset output" })
map({ "v", "n" }, "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", { desc = "Show prompts" })

-- Github copilot keymaps
map("i", "<c-t>", 'copilot#Accept("\\<CR>")', { desc = "Copilot accept", expr = true, replace_keycodes = false })
map("i", "<c-y>", "<Plug>(copilot-accept-word)", { desc = "Copilot accept word" })
vim.g.copilot_no_tab_map = true

require("CopilotChat").setup({
    mappings = {
        close = {
            normal = "q",
            insert = "",
        },
    },
})
