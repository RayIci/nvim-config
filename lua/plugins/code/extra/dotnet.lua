return {
    {
        "MoaidHathot/dotnet.nvim",
        config = function()
            require("dotnet").setup()
            require("which-key").add({
                { "-d", group = "Dotnet" },
                { "-di", "<cmd>DotnetUI new_item<cr>", desc = "New item" },
                { "-df", "<cmd>DotnetUI file boostrap<cr>", desc = "File bootstrap" },
                { "-dn", "<cmd>DotnetUI project package add<cr>", desc = "Nuget package  add" },
                { "-dN", "<cmd>DotnetUI project package remove<cr>", desc = "Nuget package  remove" },
                { "-dp", "<cmd>DotnetUI project reference add<cr>", desc = "Project reference add" },
                { "-dP", "<cmd>DotnetUI project reference remove<cr>", desc = "Project reference remove" },
            })
        end,
    },
}
