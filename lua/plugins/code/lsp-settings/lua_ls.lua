return {
    settings = {
        Lua = {
            runtime = {
                -- Dichiara la versione Lua usata da Neovim
                version = "LuaJIT",
            },
            diagnostics = {
                -- Riconosci 'vim' come variabile globale
                globals = { "vim" },
            },
            workspace = {
                -- Rendi visibili i file runtime di Neovim
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,     -- Disabilita la telemetria
            },
        },
    },
}
