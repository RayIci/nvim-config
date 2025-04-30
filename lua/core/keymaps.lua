local map = require("utils.keymaps").map
local add = require("which-key").add

-- Disable space behaviour in normal and visual mode
map({ "n", "v" }, "<space>", "<nop>")

-- Keep last yanked when pasting
map("v", "p", '"_dP', { desc = "Paste" })

-- Center next and previous position
map("n", "<c-i>", "<c-i>zz", { desc = "Next position" })
map("n", "<c-o>", "<c-o>zz", { desc = "Prev position" })

-- Remap ctrl+c to esc (used for copilot to clear virtual text when using ctrl+c)
map("i", "<c-c>", "<esc>", { desc = "Ctrl+c to esc" })

-- Remap to nothing alt+space (since idk why but if you press it default is exit insert)
map("i", "<a-space>", "<nop>")

add({
    -- File save
    { "<c-s>", "<cmd>w<cr>", desc = "Save file" },
    { "<c-a>", "<cmd>noautocmd w<cr>", desc = "Save without formatting" },

    -- Deletion
    {
        "x",
        '"_x',
        desc = "Delete single char (no buff save)",
        mode = { "n", "x", "v" },
    },

    -- Vertical scroll and center
    { "<c-d>", "<c-d>zz", desc = "Scroll down" },
    { "<c-u>", "<c-u>zz", desc = "Scroll up" },

    -- Find and center
    { "n", "nzzzv", desc = "Find next" },
    { "N", "Nzzzv", desc = "Find previous" },

    -- Remove find
    { "<c-x>", "<cmd>noh<cr>", desc = "Clear find" },

    -- Windows management
    { "<leader>v", "<c-w>v", desc = "Split window vertically" },
    { "<leader>h", "<c-w>s", desc = "Split window hrizontally" },
    { "<leader>=", "<c-w>=", desc = "Split window reset Size" },

    -- Move between windows
    { "<c-h>", "<cmd>wincmd h<cr>", desc = "Move on left window" },
    { "<c-j>", "<cmd>wincmd j<cr>", desc = "Move on bottom window" },
    { "<c-k>", "<cmd>wincmd k<cr>", desc = "Move on up window" },
    { "<c-l>", "<cmd>wincmd l<cr>", desc = "Move on right window" },

    -- Move code line Up, Down
    { "J", "<cmd>m .+1<cr>==", desc = "Move line up" },
    { "K", "<cmd>m .-2<cr>==", desc = "Move line down" },
    {
        "J",
        ":m '> +1<cr>gv=gv",
        desc = "Move line up",
        mode = "v",
    },
    {
        "K",
        ":m '< -2<cr>gv=gv",
        desc = "Move line down",
        mode = "v",
    },

    -- Resize with arrows
    { "<Up>", [[<cmd>horizontal resize +5<cr>]], desc = "Resize horizontal (-)" },
    { "<Down>", [[<cmd>horizontal resize -5<cr>]], desc = "Resize horizontal (+)" },
    { "<Left>", [[<cmd>vertical resize +2<cr>]], desc = "Resize vertical (+)" },
    { "<Right>", [[<cmd>vertical resize -2<cr>]], desc = "Resize vertical (-)" },

    -- Buffers
    { "<leader>b", group = "Buffers" },
    { "<leader>bn", "<cmd>enew<cr>", desc = "New" },

    -- Tabs
    { "<leader>j", group = "Tabs" },
    { "<leader>jn", "<cmd>tabnew<cr>", desc = "New" },
    { "<leader><Tab>", "<cmd>tabn<cr>", desc = "Tab next" },
    { "<leader><S-Tab>", "<cmd>tabp<cr>", desc = "Tab previous" },
    { "<leader>js", "<cmd>tab split<cr>", desc = "Split" },

    -- Close keys
    { "<leader>x", group = "Close" },
    { "<leader>xw", ":Bdelete<cr>", desc = "Buffer close" },
    { "<leader>xf", ":Bdelete!<cr>", desc = "Buffer close force (no save)" },
    { "<leader>xa", ":bufdo :Bdelete<cr>", desc = "Buffer close all" },
    { "<leader>xs", "<cmd>close<CR>", desc = "Split close" },
    { "<leader>xj", "<cmd>tabclose<cr>", desc = "Tab close" },

    -- Stay in indent mode
    {
        "<",
        "<gv",
        desc = "Indent left",
        mode = "v",
    },
    {
        ">",
        ">gv",
        desc = "Indent right",
        mode = "v",
    },

    -- Quickfix and loclist
    { "<leader>q", group = "Lists" },
    { "<leader>qq", "<cmd>Copen<cr>", desc = "Quickfix open" },
    { "<leader>ql", "<cmd>Lopen<cr>", desc = "Loclist open" },

    -- General options
    { "<leader>o", group = "Options" },
    { "<leader>ow", "<cmd>set wrap!<cr>", desc = "Toggle line wrap" },
    { "<leader>oc", "<cmd>set cursorline!<cr>", desc = "Toggle cursor line" },
    { "<leader>ot", "<cmd>set list!<cr>", desc = "Toggle list" },

    { "<leader>ol", group = "Colorcolumn" },
    { "<leader>ole", "<cmd>lua vim.opt.colorcolumn = '100'<cr>", desc = "Enable" },
    { "<leader>old", "<cmd>lua vim.opt.colorcolumn = ''<cr>", desc = "Disable" },
})
