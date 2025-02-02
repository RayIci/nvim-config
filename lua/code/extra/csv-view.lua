local M = {
    'hat0uma/csvview.nvim',
}

function M.config()
    require "csvview".setup {
        display_mode = "border"
    }

    require "which-key".add {
        { "-c",  group = "CSV" },
        { "-ct", "<cmd>CsvViewToggle<cr>",  desc = "CSV View toggle" },
        { "-ct", "<cmd>CsvViewEnable<cr>",  desc = "CSV View enable" },
        { "-ct", "<cmd>CsvViewDisable<cr>", desc = "CSV View disable" },
    }
end

return M
