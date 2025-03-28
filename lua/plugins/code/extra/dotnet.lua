return {
    {
        "GustavEikaas/easy-dotnet.nvim",
        -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
        -- are highly recommended for a better experience
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        config = function()
            local map = require("utils.keymaps").map
            require("which-key").add({ "-d", group = "Dotnet" }, { "-dS", group = "Solution" })
            map("n", "-dv", "<cmd>Dotnet project view<cr>", { desc = "Project view" })
            map("n", "-dV", "<cmd>Dotnet project view default<cr>", { desc = "Project view default" })
            map("n", "-ds", "<cmd>Dotnet secrets<cr>", { desc = "Secrets" })
            map("n", "-dr", "<cmd>Dotnet restore<cr>", { desc = "Restore" })
            map("n", "-dc", "<cmd>Dotnet clean<cr>", { desc = "Clean" })
            map("n", "-df", "<cmd>Dotnet createfile<cr>", { desc = "Create file" })
            map("n", "-dSs", "<cmd>Dotnet solution select<cr>", { desc = "Solution select" })
            map("n", "-dSa", "<cmd>Dotnet solution add<cr>", { desc = "Solution add" })
            map("n", "-dSr", "<cmd>Dotnet solution remove<cr>", { desc = "Solution remove" })

            local function get_secret_path(secret_guid)
                local path = ""
                local home_dir = vim.fn.expand("~")
                if require("easy-dotnet.extensions").isWindows() then
                    local secret_path = home_dir
                        .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
                        .. secret_guid
                        .. "\\secrets.json"
                    path = secret_path
                else
                    local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
                    path = secret_path
                end
                return path
            end

            local dotnet = require("easy-dotnet")
            -- Options are not required
            dotnet.setup({
                test_runner = {
                    ---@type "split" | "float" | "buf"
                    viewmode = "float",
                    enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
                    noBuild = true,
                    noRestore = true,
                    icons = {
                        passed = "",
                        skipped = "",
                        failed = "",
                        success = "",
                        reload = "",
                        test = "",
                        sln = "󰘐",
                        project = "󰘐",
                        dir = "",
                        package = "",
                    },
                    mappings = {
                        run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
                        filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
                        debug_test = { lhs = "<leader>d", desc = "debug test" },
                        go_to_file = { lhs = "g", desc = "got to file" },
                        run_all = { lhs = "<leader>R", desc = "run all tests" },
                        run = { lhs = "<leader>r", desc = "run test" },
                        peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
                        expand = { lhs = "o", desc = "expand" },
                        expand_node = { lhs = "E", desc = "expand node" },
                        expand_all = { lhs = "-", desc = "expand all" },
                        collapse_all = { lhs = "W", desc = "collapse all" },
                        close = { lhs = "q", desc = "close testrunner" },
                        refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
                    },
                    --- Optional table of extra args e.g "--blame crash"
                    additional_args = {},
                },
                ---@param action "test" | "restore" | "build" | "run"
                terminal = function(path, action, args)
                    local commands = {
                        run = function()
                            return string.format("dotnet run --project %s %s", path, args)
                        end,
                        test = function()
                            return string.format("dotnet test %s %s", path, args)
                        end,
                        restore = function()
                            return string.format("dotnet restore %s %s", path, args)
                        end,
                        build = function()
                            return string.format("dotnet build %s %s", path, args)
                        end,
                        watch = function()
                            return string.format("dotnet watch --project %s %s", path, args)
                        end,
                    }

                    local command = commands[action]() .. "\r"
                    vim.cmd("vsplit")
                    vim.cmd("term " .. command)
                end,
                secrets = {
                    path = get_secret_path,
                },
                csproj_mappings = true,
                fsproj_mappings = true,
                auto_bootstrap_namespace = {
                    --block_scoped, file_scoped
                    type = "block_scoped",
                    enabled = true,
                },
                -- choose which picker to use with the plugin
                -- possible values are "telescope" | "fzf" | "snacks" | "basic"
                -- if no picker is specified, the plugin will determine
                -- the available one automatically with this priority:
                -- telescope -> fzf -> snacks ->  basic
                picker = "telescope",
            })
        end,
    },
    {
        "MoaidHathot/dotnet.nvim",
        config = function()
            local map = require("utils.keymaps").map
            map("n", "-dp", "<cmd>DotnetUI project package add<cr>", { desc = "Package add" })
            map("n", "-dP", "<cmd>DotnetUI project package remove<cr>", { desc = "Package remove" })
            map("n", "-dr", "<cmd>DotnetUI project reference add<cr>", { desc = "Project reference add" })
            map("n", "-dR", "<cmd>DotnetUI project reference remove<cr>", { desc = "Project reference remove" })
            require("dotnet").setup({
                bootstrap = {
                    auto_bootstrap = false, -- Automatically call "bootstrap" when creating a new file, adding a namespace and a class to the files
                },
            })
        end,
    },
}
