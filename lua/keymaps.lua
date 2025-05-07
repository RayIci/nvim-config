local map = mnvim.keymaps.map
local mapgroup = mnvim.keymaps.map_group

-- Groups
mapgroup('<leader>g', 'Git')
mapgroup('<leader>b', 'Buffers')

map("n", '<leader>e', mnvim.explorer.actions.open_explorer, { desc = 'Open Explorer'})
map("n", '<leader>g', mnvim.explorer.actions.open_git_explorer, { desc = 'Open Git Explorer'})
map("n", '<leader>gs', mnvim.explorer.actions.open_git_explorer, { desc = 'Open Git Status'})
map("n", '<leader>bw', mnvim.explorer.actions.open_buffer_explorer, { desc = 'Open Buffer Explorer'})
