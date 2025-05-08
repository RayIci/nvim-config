mnvim.code.packages.install("lsp", "pyright")
mnvim.code.lsp.register("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
            },
        },
    },
})

mnvim.code.packages.install("formatter", "black")
mnvim.code.packages.install("formatter", "isort")
mnvim.code.formatters.register_for_filetype("python", "black")
mnvim.code.formatters.register_for_filetype("python", "isort")

mnvim.code.packages.install("linter", "flake8")
mnvim.code.linters.register_for_filetype("python", "flake8")
