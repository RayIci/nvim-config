return {
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
    handlers = {
        ["textDocument/hover"] = false,
    }
}
