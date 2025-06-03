mnvim.code.packages.install("lsp", "sqlls")
mnvim.code.lsp.register("sqlls")

mnvim.code.packages.install("formatter", "sql-formatter")
mnvim.code.formatters.register_for_filetype("sql", "sql_formatter")
mnvim.code.formatters.configure_formatter("sql_formatter", {
    prepend_args = {
        "--language",
        "postgres",
    },
})
