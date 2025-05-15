mnvim.code.packages.install("lsp", "dockerfile-language-server")
mnvim.code.packages.install("lsp", "docker-compose-language-service")
mnvim.code.lsp.register("dockerls")
mnvim.code.lsp.register("docker_compose_language_service")

mnvim.code.packages.install("linter", "hadolint")
mnvim.code.linters.register_for_filetype("dockerfile", "hadolint")

local dockercompose_files = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
}

function docker_fix()
    local filename = vim.fn.expand("%:t")
    for _, file in ipairs(dockercompose_files) do
        if filename == file then
            vim.bo.filetype = "yaml.docker-compose"
            return
        end
    end
end

vim.cmd([[au BufRead * lua docker_fix()]])
