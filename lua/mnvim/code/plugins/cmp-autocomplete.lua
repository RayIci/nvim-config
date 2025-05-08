-- Cmp for autocompletition
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- other dependencies
        "neovim/nvim-lspconfig",
        "onsails/lspkind.nvim",

        -- cmp dependecies
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-calc",

        -- luasnip engine dependencies
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            build = (function ()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function ()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
    },
    config = function ()
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        local mnvimcmp = mnvim.code.autocompletion
        local dk = mnvim.code.autocompletion.keymaps.default
        local cmdk = mnvim.code.autocompletion.keymaps.cmd_line

        local cmp_keymaps = {
            -- For more advanced Luasnip keymaps https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            ["<C-y>"] = cmp.config.disable,
            [dk.next_item] = cmp.mapping.select_next_item(),
            [dk.prev_item] = cmp.mapping.select_prev_item(),
            [dk.scroll_docs_down] = cmp.mapping.scroll_docs(-mnvimcmp.scroll_docs_amount),
            [dk.scroll_docs_up] = cmp.mapping.scroll_docs(mnvimcmp.scroll_docs_amount),
            [dk.select_item] = cmp.mapping.confirm({ select = true }),
            [dk.complete] = cmp.mapping.complete({}),
            [dk.abort] = cmp.mapping.abort(),
            [dk.signature_help] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.abort()
                end
                vim.lsp.buf.signature_help()
            end, { "i", "s" }),
            [dk.select_next_item] = cmp.mapping(function ()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            [dk.select_prev_item] = cmp.mapping(function ()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        }

        -- Default cmp keymaps for cmd line
        local cmd_line_keymaps = {
            [cmdk.next_item] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "c" }),
            [cmdk.prev_item] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "c" }),
            [cmdk.abort] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    fallback()
                end
            end, { "c" }),
            [cmdk.select_item] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.confirm()
                else
                    fallback()
                end
            end, { "c" }),
        }

        -- CMP and luasnip setup
        luasnip.config.setup({})
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function (args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert(cmp_keymaps),
            sources = {
                { name = "calc" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                    maxwidth = {
                        menu = 50,
                        abbr = 50,
                    },
                    ellipsis_char = "...",
                    show_labelDetails = true,
                }),
            },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmd_line_keymaps,
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmd_line_keymaps,
            sources = {
                { name = "path" },
                { name = "cmdline" },
            },
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end
}
