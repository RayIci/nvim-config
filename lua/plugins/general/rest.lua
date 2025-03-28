local M = {
    "rest-nvim/rest.nvim",
    config = function() end,
}

function M.opts(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    table.insert(opts.ensure_installed, "http")

    require("which-key").add({
        { "<leader>a", group = "Rest" },
        { "<leader>ao", "<cmp>Rest open<cr>", desc = "Open" },
        { "<leader>ar", "<cmp>Rest run <cr>", desc = "Run request under cursr" },
        { "<leader>aR", M._rest_run_file, desc = "Run request name" },
        { "<leader>al", "<cmp>Rest last<cr>", desc = "Run last request" },
        { "<leader>aL", "<cmp>Rest logs<cr>", desc = "Logs" },
        { "<leader>ac", "<cmp>Rest cookies<cr>", desc = "Cookies" },

        { "<leader>ae", group = "Environemtn" },
        { "<leader>av", "<cmp>Rest show<cr>", desc = "Visualize (show)" },
        { "<leader>as", "<cmp>Rest select<cr>", desc = "Select" },
        { "<leader>ap", "<cmp>Rest set<cr>", desc = "Set from path" },
    })

    --[[
--]]
end

function M._rest_run_file()
    local file = vim.fn.input("Request name: ")
    if file ~= "" then
        vim.cmd("Rest run " .. file)
    else
        vim.notify("You insert an empty request name")
    end
end

function M._rest_register_env_from_path()
    local path = vim.fn.input("Environment path: ")
    if path ~= "" then
        vim.cmd("Rest env set " .. path)
    else
        vim.notify("You insert an empty environment path")
    end
end

return M
