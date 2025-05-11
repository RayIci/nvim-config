mnvim.code.packages.install("dap", "netcoredbg")
mnvim.plugins.install({
    "NicholasMata/nvim-dap-cs",
    config = function()
        require("dap-cs").setup({
            dap_configurations = {
                {
                    type = "coreclr",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
            netcoredbg = {
                path = mnvim.code.packages.get_bin_path() .. "netcoredbg",
            },
        })
    end,
})
