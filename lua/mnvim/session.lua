vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

mnvim.plugins.install({
    -- Autosession / restore session
    {
        "rmagatti/auto-session",
        lazy = false,
        config = function()
            require("auto-session").setup({
                session_lens = {
                    -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
                    load_on_setup = true,
                    previewer = false,
                    theme_conf = { border = true },
                },
            })
        end,
    },
})

_G.mnvim.session = {}
_G.mnvim.session.actions = {}

mnvim.session.actions.select = function()
    require("auto-session.session-lens").search_session()
end
