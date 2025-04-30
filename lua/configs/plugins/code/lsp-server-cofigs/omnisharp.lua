return {
    -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    cmd = { require("configs.mason").mason_bin_path() .. "omnisharp" },
    -- enable_import_completion = true,
    -- organize_imports_on_format = true,
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        MsBuild = {
            LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
        },
        Sdk = {
            IncludePrereleases = true,
        },
    },
}
