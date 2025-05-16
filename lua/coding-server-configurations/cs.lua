mnvim.code.packages.install("lsp", "omnisharp")
mnvim.code.lsp.register("omnisharp", {
    cmd = { "OmniSharp" },
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        MsBuild = {
            LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
            EnableDecompilationSupport = true,
        },
        Sdk = {
            IncludePrereleases = true,
        },
    },
})

mnvim.code.packages.install("formatter", "csharpier")
mnvim.code.formatters.register_for_filetype("cs", "csharpier")

mnvim.code.packages.install("dap", "netcoredbg")
mnvim.plugins.install({
    "NicholasMata/nvim-dap-cs",
    config = function()
        require("dap-cs").setup({
            dap_configurations = {
                {
                    type = "coreclr",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
                {
                    type = "coreclr",
                    name = "Input DLL",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                    end,
                },
            },
            netcoredbg = {
                path = "netcoredbg",
            },
        })
    end,
})

local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- mnvim.plugins.install({
--     "GustavEikaas/easy-dotnet.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "nvim-telescope/telescope.nvim",
--     },
--     config = function()
--         mapgroup("-d", "Dotnet")
--         mapgroup("-dS", "Solution")
--         map("n", "-dv", "<cmd>Dotnet project view<cr>", { desc = "Project view" })
--         map("n", "-dV", "<cmd>Dotnet project view default<cr>", { desc = "Project view default" })
--         map("n", "-ds", "<cmd>Dotnet secrets<cr>", { desc = "Secrets" })
--         map("n", "-dr", "<cmd>Dotnet restore<cr>", { desc = "Restore" })
--         map("n", "-dc", "<cmd>Dotnet clean<cr>", { desc = "Clean" })
--         map("n", "-dSs", "<cmd>Dotnet solution select<cr>", { desc = "Solution select" })
--         map("n", "-dSa", "<cmd>Dotnet solution add<cr>", { desc = "Solution add" })
--         map("n", "-dSr", "<cmd>Dotnet solution remove<cr>", { desc = "Solution remove" })
--
--         local function get_secret_path(secret_guid)
--             local path = ""
--             local home_dir = vim.fn.expand("~")
--             if require("easy-dotnet.extensions").isWindows() then
--                 local secret_path = home_dir .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\" .. secret_guid .. "\\secrets.json"
--                 path = secret_path
--             else
--                 local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
--                 path = secret_path
--             end
--             return path
--         end
--
--         local dotnet = require("easy-dotnet")
--         dotnet.setup({
--             ---@param action "test" | "restore" | "build" | "run"
--             terminal = function(path, action, args)
--                 local commands = {
--                     run = function()
--                         return string.format("dotnet run --project %s %s", path, args)
--                     end,
--                     test = function()
--                         return string.format("dotnet test %s %s", path, args)
--                     end,
--                     restore = function()
--                         return string.format("dotnet restore %s %s", path, args)
--                     end,
--                     build = function()
--                         return string.format("dotnet build %s %s", path, args)
--                     end,
--                     watch = function()
--                         return string.format("dotnet watch --project %s %s", path, args)
--                     end,
--                 }
--
--                 local command = commands[action]() .. "\r"
--                 vim.cmd("vsplit")
--                 vim.cmd("term " .. command)
--             end,
--             secrets = {
--                 path = get_secret_path,
--             },
--             csproj_mappings = true,
--             fsproj_mappings = true,
--             auto_bootstrap_namespace = {
--                 --block_scoped, file_scoped
--                 type = "block_scoped",
--                 enabled = true,
--             },
--             picker = "telescope",
--         })
--     end,
-- })
--
-- mnvim.plugins.install({
--     "MoaidHathot/dotnet.nvim",
--     config = function()
--         local map = require("utils.keymaps").map
--         map("n", "-dn", "<cmd>DotnetUI new_item<cr>", { desc = "New item" })
--         map("n", "-dp", "<cmd>DotnetUI project package add<cr>", { desc = "Package add" })
--         map("n", "-dP", "<cmd>DotnetUI project package remove<cr>", { desc = "Package remove" })
--         map("n", "-dr", "<cmd>DotnetUI project reference add<cr>", { desc = "Project reference add" })
--         map("n", "-dR", "<cmd>DotnetUI project reference remove<cr>", { desc = "Project reference remove" })
--         require("dotnet").setup({
--             bootstrap = {
--                 auto_bootstrap = false, -- Automatically call "bootstrap" when creating a new file, adding a namespace and a class to the files
--             },
--         })
--     end,
-- })
