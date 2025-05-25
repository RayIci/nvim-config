mnvim.plugins.install({
    {
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
            },
            config = function()
                local noice = require("noice")

                noice.setup({
                    lsp = {
                        progress = {
                            enabled = true,
                        },
                        override = {
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                            ["vim.lsp.util.stylize_markdown"] = true,
                            ["cmp.entry.get_documentation"] = true,
                        },
                        hover = {
                            enabled = true,
                            silent = true,
                            view = nil,
                        },
                        signature = {
                            enabled = true,
                            auto_open = {
                                enabled = true,
                                trigger = true,
                                luasnip = true,
                            },
                            view = nil,
                        },
                        documentation = {
                            view = "hover",
                        },
                    },
                    cmdline = {
                        enabled = true,
                        view = "cmdline_popup",
                        format = {
                            cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
                            help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰮦 :" },
                            search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
                            search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
                            filter = { pattern = "^:%s*!", icon = " $ :", lang = "bash" },
                            lua = {
                                pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                                icon = "  :",
                                lang = "lua",
                            },
                            input = { view = "cmdline_input", icon = " 󰥻 :" }, -- Used by input()
                        },
                    },
                    views = {
                        popupmenu = {
                            relative = "editor",
                            border = "rounded",
                            position = {
                                row = 8,
                                col = "50%",
                            },
                            win_options = {
                                winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
                            },
                        },
                        mini = {
                            size = {
                                width = "auto",
                                height = "auto",
                                max_height = 15,
                            },
                            position = {
                                row = -2,
                                col = "100%",
                            },
                        },
                        hover = {
                            border = {
                                style = "rounded",
                                padding = { 0, 0 },
                            },
                            position = {
                                row = 2,
                            },
                            win_options = {
                                winhighlight = {
                                    Normal = "NormalFloat",
                                    FloatBorder = "FloatBorder",
                                },
                            },
                        },
                    },
                    routes = {
                        {
                            filter = {
                                event = "msg_show",
                                any = {
                                    { find = "%d+L, %d+B" },
                                    { find = "; after #%d+" },
                                    { find = "; before #%d+" },
                                    { find = "%d fewer lines" },
                                    { find = "%d more lines" },
                                },
                            },
                            opts = { skip = true },
                        },
                    },
                })
            end,
        },
    },
})

-- Note: This is not a telescope thing and should not stay here.
--       But by convention all the pickers are under the telescope `namespace`.
function mnvim.telescope.actions.pick_notification()
    vim.cmd("Noice")
end
