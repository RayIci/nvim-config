local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- other dependencies
        "neovim/nvim-lspconfig",
        "github/copilot.vim",
        "onsails/lspkind.nvim",

        -- cmp dependecies
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        -- luasnip engine dependencies
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
    },
}

function M.get_mappings(cmp, luasnip)
    return {
        ["<C-y>"] = cmp.config.disable,

        -- Select the next and previous item
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        ["<Enter>"] = cmp.mapping.confirm({ select = true }),

        -- Manually trigger a completion from nvim-cmp.
        ["<C-Space>"] = cmp.mapping.complete({}),

        -- Abort
        ["<C-a>"] = cmp.mapping.abort(),

        -- Open signature help and close cmp popup
        ["<C-s>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            end
            vim.lsp.buf.signature_help()
        end, { "i", "s" }),

        -- Jump over the positional completable field of the snippet
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),

        -- For more advanced Luasnip keymaps https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    }
end

function M.get_cmdline_mappings(cmp)
    return {
        ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "c" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "c" }),


        ["<C-a>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            else
                fallback()
            end
        end, { "c" }),

        ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm()
            else
                fallback()
            end
        end, { "c" }),
    }
end

function M.config()
    local cmp = require "cmp" -- See `:help cmp`
    local luasnip = require "luasnip"

    luasnip.config.setup {}

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        completion = { completeopt = "menu,menuone,noinsert" },

        -- For understanding these mappings read `:help ins-completion`
        mapping = cmp.mapping.preset.insert(M.get_mappings(cmp, luasnip)),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },

        formatting = {
            format = require "lspkind".cmp_format {
                mode = 'symbol', -- show only symbol annotations
                maxwidth = {
                    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                    menu = 50,  -- leading text (labelDetails)
                    abbr = 50,  -- actual suggestion item
                },
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            }
        }
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = M.get_cmdline_mappings(cmp),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = M.get_cmdline_mappings(cmp),
        sources = {
            { name = 'path' },
            { name = 'cmdline' },
        },
        matching = { disallow_symbol_nonprefix_matching = false }
    })
end

return M
