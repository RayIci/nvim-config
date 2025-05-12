-- Telescope
local common_file_ignore_patterns = {
    "%.ropeproject/",
    "node_modules",
    "%.git/",
    "%.venv.*/",
    "__pycache__",
    ".pytest_cache",
}

mnvim.telescope.file_ignore_by_pattern = common_file_ignore_patterns
mnvim.telescope.grep_ignore_by_pattern = common_file_ignore_patterns

-- Explorer
mnvim.explorer.filtered_items = {
    hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
        "__pycache__",
        ".virtual_documents",
        ".git",
        ".python-version",
        ".pytest_cache",
        ".ropeproject",
    },
    hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
        ".venv*",
        ".env*",
        "*.egg-info",
    },
    never_show = {
        ".DS_Store",
        "thumbs.db",
        "__pycache__",
    },
}
