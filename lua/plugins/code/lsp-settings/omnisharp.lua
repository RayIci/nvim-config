return {
    -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    cmd = { require("utils.mason").mason_bins_path() .. "omnisharp" },
    enable_import_completion = true,
    organize_imports_on_format = true,
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        MsBuild = {
            LoadProjectsOnDemand = nil,
        },
        RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = nil,
        },
        Sdk = {
            IncludePrereleases = true,
        },
    },
}
