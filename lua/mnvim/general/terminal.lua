mnvim.terminal.keymaps.toggle = "<c-t>"

local on_terminal_opens = {}
local on_terminal_creates = {}

---Add a callback when the terminal opens
---@param event function the function to be executed that takes the terminal as argument
mnvim.terminal.on_terminal_opens = function(event)
    table.insert(on_terminal_opens, event)
end

---Add a callback when the terminal create
---@param event function the function to be executed that takes the terminal as argument
mnvim.terminal.on_terminal_creates = function(event)
    table.insert(on_terminal_creates, event)
end

mnvim.plugins.install({
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            open_mapping = mnvim.terminal.keymaps.toggle,
            insert_mappings = false,
            size = function(term)
                if term.direction == "horizontal" then
                    return 25
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            on_open = function(terminal)
                for _, event in ipairs(on_terminal_opens) do
                    event(terminal)
                end
            end,
            on_create = function(terminal)
                for _, event in ipairs(on_terminal_creates) do
                    event(terminal)
                end
            end,
        })
    end,
})

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

local get_terminal = function()
    return require("toggleterm.terminal").Terminal
end

mnvim.terminal.actions.new_floating = function()
    local fterm = get_terminal():new({ direction = "float" })
    fterm:toggle()
end

mnvim.terminal.actions.new_horizontal = function()
    local hterm = get_terminal():new({ direction = "horizontal" })
    hterm:toggle()
end

mnvim.terminal.actions.new_vertical = function()
    local vterm = get_terminal():new({ direction = "vertical" })
    vterm:toggle()
end
