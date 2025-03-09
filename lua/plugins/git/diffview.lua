local M = {
    "sindrets/diffview.nvim",
}

function M.config()
    require("diffview").setup({})
    M.keymaps()
end

function M.keymaps()
    require("which-key").add({
        { "<leader>g",  group = "Git" },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview" },
        { "<leader>gD", "<cmd>DiffviewClose<cr>",         desc = "Diffview Close" },
        { "<leader>gf", "<cmd>DiffviewFileHistory<cr>",   desc = "Diffview File History" },
        { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History Current File" },
        { "<leader>gr", "<cmd>DiffviewRefresh<cr>",       desc = "Diffview Refresh" },
        { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>",   desc = "Diffview Toggle Files" },
        { "<leader>gT", "<cmd>DiffviewToggleFiles %<cr>", desc = "Diffview Toggle Files Current File" },
        { "<leader>gl", "<cmd>LazyGit<cr>",               desc = "Open lazy git" },
    })
end

return M
