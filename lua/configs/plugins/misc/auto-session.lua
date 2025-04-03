require("which-key").add({
    { "<leader>s", require("auto-session.session-lens").search_session, desc = "Search sessions" },
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
    session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = true,
        previewer = false,
        theme_conf = { border = true },
    },
})
