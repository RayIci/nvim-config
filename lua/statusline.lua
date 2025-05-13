local icons = mnvim.ui.icons
local colors = {
    bg = "#1d1d1d",
    fg = "#ffffff",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#409127",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

mnvim.statusline.insert_left({
    "mode",
    padding = { left = 1, right = 1 },
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
        }
        return { fg = colors.fg, bg = mode_color[vim.fn.mode()] }
    end,
})

mnvim.statusline.insert_left({
    "filesize",
    cond = conditions.buffer_not_empty,
})

mnvim.statusline.insert_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { gui = "bold" },
})

mnvim.statusline.insert_left({ "location" })

mnvim.statusline.insert_left({ "progress" })

mnvim.statusline.insert_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = icons.diagnostics.BoldError .. " ", warn = icons.diagnostics.BoldWarning .. " ", info = icons.diagnostics.BoldInformation .. " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
    },
})

mnvim.statusline.insert_left({
    "macro_recording",
    "%S",
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
mnvim.statusline.insert_left({
    function()
        return "%="
    end,
})

mnvim.statusline.insert_right({
    function()
        local venv = os.getenv("VIRTUAL_ENV")
        return venv and "(" .. icons.code.python .. " " .. vim.fn.fnamemodify(venv, ":t") .. ")" or ""
    end,
    color = { fg = colors.cyan },
})

mnvim.statusline.insert_right({
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    -- icon = " LSP:",
    color = { fg = "#ffffff", gui = "bold" },
})

-- Add components to right sections
mnvim.statusline.insert_right({
    "o:encoding", -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
})

mnvim.statusline.insert_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
})

mnvim.statusline.insert_right({
    "branch",
    icon = icons.git.Branch,
    color = { fg = colors.violet, gui = "bold" },
})

mnvim.statusline.insert_right({
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = { added = " ", modified = "󰝤 ", removed = " " },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})
