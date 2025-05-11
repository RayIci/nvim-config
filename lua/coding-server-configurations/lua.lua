mnvim.code.packages.install("lsp", "lua-language-server")
mnvim.code.lsp.register("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

mnvim.code.packages.install("formatter", "stylua")
mnvim.code.formatters.register_for_filetype("lua", "stylua")
