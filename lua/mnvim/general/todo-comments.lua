mnvim.plugins.install({
    -- Quickly Jump through the todo tags
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        local fix_icons = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        }
        local todo_icons = { icon = " ", color = "info" }
        local hack_icons = { icon = " ", color = "warning", alt = { "DON SKIP" } }
        local warn_icons = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } }
        local perf_icons = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } }
        local note_icons = { icon = " ", color = "hint", alt = { "INFO", "READ", "COLORS" } }
        local test_icons = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } }

        todo_comments.setup({
            keywords = {
                FIX = fix_icons,
                TODO = todo_icons,
                HACK = hack_icons,
                WARN = warn_icons,
                PERF = perf_icons,
                NOTE = note_icons,
                TEST = test_icons,

                fix = fix_icons,
                todo = todo_icons,
                hack = hack_icons,
                warn = warn_icons,
                perf = perf_icons,
                note = note_icons,
                test = test_icons,

                Fix = fix_icons,
                Todo = todo_icons,
                Hack = hack_icons,
                Warn = warn_icons,
                Perf = perf_icons,
                Note = note_icons,
                Test = test_icons,
            },
        })
    end,
})

_G.mnvim.comments.actions = {}

mnvim.comments.actions.next_todo = function()
    require("todo-comments").jump_next()
end

mnvim.comments.actions.prev_todo = function()
    require("todo-comments").jump_prev()
end

mnvim.comments.actions.pick_todo = function()
    require("snacks").picker.todo_comments()
end
