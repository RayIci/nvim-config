-- To install lazygit see the following link: https://github.com/jesseduffield/lazygit?tab=readme-ov-file

local M = {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    vim.g.lazygit_floating_window_scaling_factor = 1                                -- scaling factor for floating window
    vim.g.lazygit_floating_window_border_chars = { '', '', '', '', '', '', '', '' } -- customize lazygit popup window border characters
end

return M
