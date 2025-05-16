-- Funzione che esegue `dotnet new list`, mostra i template e permette di selezionarne uno
local function select_dotnet_template()
    -- Esegui il comando e prendi l'output come lista di righe
    local output = vim.fn.systemlist("dotnet new list")

    -- Rimuovi le prime righe se sono intestazioni inutili
    -- Adatta questo filtro in base all'output effettivo del tuo comando
    local templates = {}
    for _, line in ipairs(output) do
        -- Rimuovi righe vuote o intestazioni
        if line:match("%S") and not line:match("^%-") then
            table.insert(templates, line)
        end
    end

    -- Usa vim.ui.select per mostrare una lista selezionabile
    vim.ui.select(templates, {
        prompt = "Scegli un template dotnet:",
    }, function(choice)
        if choice then
            vim.notify("Hai selezionato: " .. choice, vim.log.levels.INFO)
            -- Qui puoi parsare il nome esatto del template e usarlo per creare un progetto
            -- oppure aprire una finestra popup, ecc.
        end
    end)
end

-- Mappa il comando a un tasto o un comando Neovim
-- vim.api.nvim_create_user_command("DotnetSelectTemplate", select_dotnet_template, {})
