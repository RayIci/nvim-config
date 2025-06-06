local register_package = require("configs.mason").register_package

register_package("formatter", "prettier")
register_package("formatter", "shfmt")
register_package("formatter", "black")
register_package("formatter", "isort")
register_package("formatter", "clang-format")
register_package("formatter", "rustywind")
register_package("formatter", "sqlfmt")
register_package("formatter", "stylua")
register_package("formatter", "csharpier")

local conform = require("conform")
local formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    rust = { "rustywind" },
    sql = { "sqlfmt" },
    sh = { "shfmt" },
    csharp = { "csharpier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
}

local formatters = {
    isort = {
        prepend_args = { "--profile", "black" },
    },
    shfmt = {
        args = { "-i", "4" },
    },
}

conform.setup({
    formatters_by_ft = formatters_by_ft,
    formatters = formatters,
    timeout_ms = 0,
    format_after_save = {
        lsp_format = "fallback",
        async = true,
    },
})

local map = require("utils.keymaps").map
map("n", "<leader>f", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", { desc = "Format file" })
map("x", "<leader>f", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
        range = {
            start = vim.api.nvim_buf_get_mark(0, "<"), -- inizio selezione visual
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"), -- fine selezione visual
        },
    })
end, { desc = "Format selection" })
