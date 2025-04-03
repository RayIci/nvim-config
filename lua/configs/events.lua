local M = {}

function M.on_toggleterm_open(terminal)
    -- vim.print(require("venv-selector").get_active_venv())
    local path_venv = os.getenv("VIRTUAL_ENV")
    if path_venv ~= nil then
        -- TODO: Abstract those in utils or maybe i can start to structure things better
        if require("utils.os").is_windows() then
            vim.api.nvim_chan_send(terminal.job_id, path_venv .. "\\Scripts\\activate\n")
            vim.api.nvim_chan_send(terminal.job_id, "cls\n")
        else
            vim.api.nvim_chan_send(terminal.job_id, "source " .. path_venv .. "/bin/activate\n")
            vim.api.nvim_chan_send(terminal.job_id, "clear\n")
        end
    end
end

function M.on_toggleterm_create(terminal)
    -- Activate the python venv when you create a new terminal
end

return M
