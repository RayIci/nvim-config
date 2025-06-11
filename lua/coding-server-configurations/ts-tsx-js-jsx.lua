mnvim.code.packages.install("lsp", "typescript-language-server")
mnvim.code.lsp.register("ts_ls")

mnvim.code.packages.install("formatter", "prettier")
mnvim.code.formatters.register_for_filetype("typescript", "prettier")
mnvim.code.formatters.register_for_filetype("typescriptreact", "prettier")
mnvim.code.formatters.register_for_filetype("javascript", "prettier")
mnvim.code.formatters.register_for_filetype("javascriptreact", "prettier")

mnvim.code.linters.register_for_filetype("typescript", "eslint")
mnvim.code.linters.register_for_filetype("typescriptreact", "eslint")
mnvim.code.linters.register_for_filetype("javascript", "eslint")
mnvim.code.linters.register_for_filetype("javascriptreact", "eslint")
