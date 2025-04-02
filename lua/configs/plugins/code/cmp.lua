local luasnip = require("luasnip")
local cmp = require("cmp")

-- Default cmp keymaps
local cmp_keymaps = {
    -- For more advanced Luasnip keymaps https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    ["<C-y>"] = cmp.config.disable,
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<Enter>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-a>"] = cmp.mapping.abort(),
    ["<C-s>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.abort()
        end
        vim.lsp.buf.signature_help()
    end, { "i", "s" }),
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
}

-- Default cmp keymaps for cmd line
local cmd_line_keymaps = {
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

-- CMP and luasnip setup
luasnip.config.setup({})
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = { completeopt = "menu,menuone,noinsert" },
    mapping = cmp.mapping.preset.insert(cmp_keymaps),
    sources = {
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
