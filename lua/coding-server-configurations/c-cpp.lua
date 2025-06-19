mnvim.code.packages.install("formatter", "clang-format")
mnvim.code.formatters.register_for_filetype("c", "clang-format")
mnvim.code.formatters.register_for_filetype("cpp", "clang-format")

mnvim.code.packages.install("lsp", "clangd")
mnvim.code.lsp.register("clangd")
