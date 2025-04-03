return {
    -- Diffview to see differences
    {
        "sindrets/diffview.nvim",
        config = require("utils.configs").configure("git.diffview"),
    },

    -- Git conflict for better merge
    {
        "akinsho/git-conflict.nvim",
        config = require("utils.configs").configure("git.git-conflict"),
        version = "*",
    },

    -- Gitsigns for line git signs
    {
        "lewis6991/gitsigns.nvim",
        config = require("utils.configs").configure("git.gitsigns"),
        dependecies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Lazygit for git ui
    {
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
    },
}
