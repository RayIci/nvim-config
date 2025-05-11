local M = {}

function M.config()
    require("bufferline").setup({
        options = {
            mode = "buffers", -- "buffers" | "tabs"  set to "tabs" to only show tabpages instead
            themable = true,  -- allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            buffer_close_icon = mnvim.ui.buffers.icons.close,
            close_command = ":Bdelete",
            close_icon = mnvim.ui.buffers.icons.close,
            path_components = 1, -- Show only the file name without the directory
            modified_icon = mnvim.ui.buffers.icons.modified,
            max_name_length = 30,
            max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
            tab_size = 21,
            diagnostics = true,
            diagnostics_update_in_insert = true,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            show_tab_indicators = false,
            indicator = {
                icon = "▎", -- this should be omitted if indicator style is not 'icon'
                style = "icon", -- 'icon' | 'underline' | 'none',
            },
            icon_pinned = mnvim.ui.buffers.icons.pin,
            minimum_padding = 1,
            maximum_padding = 5,
            maximum_length = 15,
            sort_by = nil, -- "insert_at_end",
        },
    })
end

vim.api.nvim_create_user_command("BdeleteOthers", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.fn.getbufinfo({buflisted = 1})) do
    if buf.bufnr ~= current then
      vim.cmd("Bdelete " .. buf.bufnr)
    end
  end
end, {})

function M.new()
    vim.cmd("enew")
end

function M.close()
    vim.cmd("Bdelete")
end

function M.close_all()
    vim.cmd(":bufdo :Bdelete")
end

function M.close_force()
    vim.cmd("Bdelete!")
end

function M.close_all_force()
    vim.cmd(":bufdo :Bdelete!")
end

function M.close_all_but_this_one()
    vim.cmd("BdeleteOthers")
end

function M.move_next()
    vim.cmd("BufferLineMoveNext")
end

function M.move_previous()
    vim.cmd("BufferLineMovePrev")
end

function M.next()
    vim.cmd("BufferLineCycleNext")
end

function M.previous()
    vim.cmd("BufferLineCyclePrev")
end

function M.pin_toggle()
    vim.cmd("BufferLineTogglePin")
end

return M
