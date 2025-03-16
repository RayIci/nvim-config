-- need sed
local M = {
    "nvim-pack/nvim-spectre"
}

function M.keymaps()
    require "which-key".add {
        { "<leader>f",  group = "Find",                                                         mode = "v" },

        { "<leader>fs", "<cmd>lua require('spectre').toggle()<cr>",                             desc = "Specter toggle" },
        { "<leader>fw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",      desc = "Specter search word" },
        { "<leader>fw", "<esc><cmd>lua require('spectre').open_visual()<CR>",                   desc = "Specter search selected word", mode = { "v" } },
        { "<leader>ff", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Specter search in file" },
    }
end

function M.config()
    M.keymaps()
end

return M
