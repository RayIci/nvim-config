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
mnvim.code.formatters.configure_formatter("isort", { prepend_args = { "--profile", "black" } })
mnvim.code.formatters.register_for_filetype("python", "black")
mnvim.code.formatters.register_for_filetype("python", "isort")

mnvim.code.packages.install("linter", "flake8")
mnvim.code.linters.register_for_filetype("python", "flake8")

mnvim.code.packages.install("dap", "debugpy")
mnvim.plugins.install({
    "mfussenegger/nvim-dap-python",
    config = function()
        require("dap-python").setup(mnvim.code.packages.get_data_path() .. "packages/debugpy/venv/bin/python")
    end,
})

mnvim.terminal.on_terminal_opens(function(terminal)
    local path_venv = os.getenv("VIRTUAL_ENV")
    if path_venv ~= nil then
        if mnvim.utils.os.is_windows() then
            vim.api.nvim_chan_send(terminal.job_id, path_venv .. "\\Scripts\\activate\n")
            vim.api.nvim_chan_send(terminal.job_id, "cls\n")
        else
            vim.api.nvim_chan_send(terminal.job_id, "source " .. path_venv .. "/bin/activate\n")
            vim.api.nvim_chan_send(terminal.job_id, "clear\n")
        end
    end
end)
