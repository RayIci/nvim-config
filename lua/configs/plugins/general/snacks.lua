local M = {}

M.keys = {
    {
        "<leader>bs",
        function()
            Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
    },
    {
        "<leader>bS",
        function()
            Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
    },
}

M.scratch = { enabled = true }

return M
