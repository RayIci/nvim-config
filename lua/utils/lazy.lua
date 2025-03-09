local M = {}

M.lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

function M.initialize_lazy()
    if not (vim.uv or vim.loop).fs_stat(M.lazy_path) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, M.lazy_path })

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end

    vim.opt.rtp:prepend(M.lazy_path)
end

function M.lazy_folder(folder_name)
    return { import = folder_name }
end

function M.lazy_custom_plugin(direcotry, config_funciton)
    return {
        dir = direcotry,
        config = config_funciton
    }
end

return M
