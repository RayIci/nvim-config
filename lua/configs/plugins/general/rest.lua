local M = {}

function M.opts(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    table.insert(opts.ensure_installed, "http")

    require("which-key").add({
        { "<leader>a", group = "Rest" },
        { "<leader>ae", group = "Environement" },
    })

    local map = require("utils.keymaps").map
    map("n", "<leader>ao", "<cmd>Rest open<cr>", { desc = "Open" })
    map("n", "<leader>ar", "<cmd>Rest run <cr>", { desc = "Run request under cursr" })
    map("n", "<leader>aR", M._rest_run_file, { desc = "Run request name" })
    map("n", "<leader>al", "<cmd>Rest last<cr>", { desc = "Run last request" })
    map("n", "<leader>aL", "<cmd>Rest logs<cr>", { desc = "Logs" })
    map("n", "<leader>ac", "<cmd>Rest cookies<cr>", { desc = "Cookies" })

    map("n", "<leader>av", "<cmd>Rest show<cr>", { desc = "Visualize (show)" })
    map("n", "<leader>as", "<cmd>Rest select<cr>", { desc = "Select" })
    map("n", "<leader>ap", "<cmd>Rest set<cr>", { desc = "Set from path" })

    opts.winbar = true

    return opts
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
