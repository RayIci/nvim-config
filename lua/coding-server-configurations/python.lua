-- Python LSP
mnvim.code.packages.install("lsp", "pyright")
mnvim.code.lsp.register("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                -- diagnosticMode = "workspace",
                typeCheckingMode = "standard",
            },
        },
    },
})

-- Python formatter
mnvim.code.packages.install("formatter", "black")
mnvim.code.packages.install("formatter", "isort")
mnvim.code.formatters.configure_formatter("isort", { prepend_args = { "--profile", "black" } })
mnvim.code.formatters.register_for_filetype("python", "black")
mnvim.code.formatters.register_for_filetype("python", "isort")

-- Python linter
-- mnvim.code.packages.install("linter", "flake8")
-- mnvim.code.linters.register_for_filetype("python", "flake8")

-- Python debugger adapter
mnvim.code.packages.install("dap", "debugpy")
mnvim.plugins.install({
    "mfussenegger/nvim-dap-python",
    config = function()
        require("dap-python").setup(mnvim.code.packages.get_data_path() .. "packages/debugpy/venv/bin/python")
    end,
})

-- Python test adapter
mnvim.plugins.install({
    "nvim-neotest/neotest-python",
})

mnvim.code.test.adapter_add(function()
    return require("neotest-python")({
        runner = "pytest",
    })
end)

-- Virtual environment selector
-- other plugin: "AckslD/swenv.nvim"
mnvim.plugins.install({
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    branch = "regexp",
    event = "VeryLazy",
    config = function()
        require("venv-selector").setup()
        mnvim.keymaps.map_group("-p", "Python")
        mnvim.keymaps.map_group("-pv", "Virtual environment")
        mnvim.keymaps.map("n", "-pvs", "<cmd>VenvSelect<cr>", { desc = "Select virtual environment" })
        mnvim.keymaps.map("n", "-pvc", "<cmd>VenvSelectCached<cr>", { desc = "Select virtual environment" })
    end,
})

-- When toggling the terminal activate the virtual environment
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

-- Add to the bottom statusline if a virtual environment is active
mnvim.statusline.insert_right({
    function()
        local venv = os.getenv("VIRTUAL_ENV")
        return venv and "(" .. mnvim.ui.icons.code.python .. " " .. vim.fn.fnamemodify(venv, ":t") .. ")" or ""
    end,
    color = { fg = mnvim.ui.colors.cyan },
})
