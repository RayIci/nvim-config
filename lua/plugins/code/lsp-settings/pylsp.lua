return {
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = { enabled = false },
                jedi_definition = { enabled = false },
                jedi_references = { enabled = false },
                jedi_signature_help = { enabled = false },
                jedi_symbols = { enabled = false },
                pylint = { enabled = false },
                pycodestyle = { enabled = false },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                yapf = { enabled = false },
                autopep8 = { enabled = false },
                black = { enabled = false },
                jedi = { enabled = false },
                rope_rename = { enabled = false },
                jedi_hover = { enabled = false },
                rope_completion = { enabled = true },
                rope_autoimport = { enabled = true },
                pyflakes = { enabled = true },
            },
        },
    },
}
