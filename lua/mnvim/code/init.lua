mnvim.plugins.register_module("mnvim.code.plugins")
local mason = require("mnvim.code.mason")

local M = {}
M.lsp = {}
M.linters = {}
M.formatters = {}
M.dap = {}
M.treesitter = {}
M.autocompletion = {}
M.packages = {}

----------------------------------------------------------------
--- Mason: Package Manager
----------------------------------------------------------------
M.packages.actions = {}

---Open the package manager ui
function M.packages.actions.open_ui()
    vim.cmd("Mason")
end

---Get the package manager data path
---@return string the path to the package manager
function M.packages.get_data_path()
    return mason.get_mason_data_path()
end

---Get the package manager bin path
---@return string the path to the package manager bin
function M.packages.get_bin_path()
    return mason.get_mason_bin_path()
end

---Register a package with the package manager
---@param kind PackageKind the kind of the package
---@param package string | table the name of the package
function M.packages.install(kind, package)
    mason.register_package(kind, package)
end

----------------------------------------------------------------
--- Treesitter: Syntax Highlighting & Other
----------------------------------------------------------------
M.treesitter.indent = {}
M.treesitter.highlight = {}
M.treesitter.incremental_selection = {}

---@type string[]
M.treesitter.install = {}
---@type string[]
M.treesitter.ignore = {}

---@type boolean
M.treesitter.highlight.enabled = true
---@type string[]
M.treesitter.highlight.disabled_filetypes = {}
---@type number | nil max file size in bytes
---(100 * 1024 = 100kb). nil means no limit
M.treesitter.highlight.max_filesize = 100 * 1024

---@type boolean
M.treesitter.indent.enabled = true

---@type boolean
M.treesitter.incremental_selection.enabled = true

---@class IncrementalSelectionKeymaps
---@field init_selection string|nil
---@field node_incremental string|nil
---@field scope_incremental string|nil
---@field node_decremental string|nil
M.treesitter.incremental_selection.keymaps = {
    init_selection = nil,
    node_incremental = "<c-space>",
    scope_incremental = "<c-space>",
    node_decremental = nil, -- TODO: Set a keymap
}


----------------------------------------------------------------
--- LSP: Language Server Protocol
----------------------------------------------------------------
local lspconfig = require("mnvim.code.lspconfig")

M.lsp.actions = {}
M.lsp.actions.definition = vim.lsp.buf.definition
M.lsp.actions.declaration = vim.lsp.buf.declaration
M.lsp.actions.implementation = vim.lsp.buf.implementation
M.lsp.actions.references = vim.lsp.buf.references
M.lsp.actions.hover = vim.lsp.buf.hover
M.lsp.actions.rename = vim.lsp.buf.rename
M.lsp.actions.code_lens = vim.lsp.codelens.run
M.lsp.actions.code_action = function ()
    require("actions-preview").code_actions()
end

---@type function|nil Function that modifies the capabilities when assigned
---to a server. It takes in input the capabilities table and must returns
---the modified table
M.lsp.modify_capabilities = nil

---Add a function that will be called after the default on attach functionalities.
---If you want to use a new on_attach function that does not call the default one,
---set a on_attach function for each registered server.
---@param on_attach function function with first argument the client and the buffer
---number as second argument
M.lsp.add_on_attach_function = function (on_attach)
    lspconfig.add_on_attach_function(on_attach)
end

---Register an lsp
---@param lsp_server string The lsp server name
---@param lsp_config LspConfig | nil
M.lsp.register = function (lsp_server, lsp_config)
    lspconfig.register_lsp_server(lsp_server, lsp_config)
end

----------------------------------------------------------------
--- CMP: Autocompletion
----------------------------------------------------------------
M.autocompletion.keymaps = {}

--- @type number default scroll amount
M.autocompletion.scroll_docs_amount = 4

---@class AutocompletionKeymaps
---@field next_item string|nil
---@field prev_item string|nil
---@field scroll_docs_down string|nil
---@field scroll_docs_up string|nil
---@field select_item string|nil
---@field complete string|nil
---@field abort string|nil
---@field signature_help string|nil
---@field select_next_item string|nil
---@field select_prev_item string|nil

M.autocompletion.keymaps.default = {}
---@type AutocompletionKeymaps default keymaps
M.autocompletion.keymaps.default = {
    next_item = "<c-j>",
    prev_item = "<c-k>",
    scroll_docs_down = "<c-u>",
    scroll_docs_up = "<c-d>",
    select_item = "<enter>",
    complete = "<c-space>",
    abort = "<c-a>",
    signature_help = "<c-s>",
    select_next_item = "<c-l>",
    select_prev_item = "<c-h>",
}

---@class AutocompletionKeymapsCmdLine
---@field next_item string|nil
---@field prev_item string|nil
---@field select_item string|nil
---@field complete string|nil
---@field abort string|nil

M.autocompletion.keymaps.cmd_line = {}
---@type AutocompletionKeymapsCmdLine cmd line keymaps
M.autocompletion.keymaps.cmd_line = {
    next_item = "<c-j>",
    prev_item = "<c-k>",
    select_item = "<c-y>",
    abort = "<c-a>",
}

----------------------------------------------------------------
--- Formatting
----------------------------------------------------------------
local conform = require("mnvim.code.conform")
M.formatters.format_after_save = true
M.formatters.configure_formatter = conform.configure_formatter
M.formatters.register_for_filetype = conform.register_for_filetype

M.formatters.actions = {}
M.formatters.actions.format = conform.format
M.formatters.actions.format_range = conform.format_range

-------------------------------------------------------------------
--- Linters
----------------------------------------------------------------
local nvim_lint = require("mnvim.code.nvim-lint")
M.linters.configure_linter = nvim_lint.configure_linter
M.linters.register_for_filetype = nvim_lint.register_for_filetype
M.show_error_if_linter_not_found = true

----------------------------------------------------------------
--- DAP: Debug Adapter Protocol
----------------------------------------------------------------
M.dap.actions = {}

local dap = require("mnvim.code.dap")

---@alias VirtualTextPosition "line-end"
---@type VirtualTextPosition|nil The position of the virtual text
M.dap.virtual_text_position = "line-end"

M.dap.actions.adapter_add = dap.add_adapter
M.dap.actions.configuration_add = dap.add_configuration

M.dap.actions.virtual_text_toggle = dap.toggle_virtual_text

M.dap.actions.continue = dap.continue
M.dap.actions.step_over = dap.step_over
M.dap.actions.step_into = dap.step_into
M.dap.actions.step_out = dap.step_out

M.dap.actions.breakpoint_toggle = dap.breakpoint_toggle
M.dap.actions.breakpoint_conditional_add = dap.breakpoint_conditional_add
M.dap.actions.breakepoint_logpoint_add = dap.breakepoint_logpoint_add
M.dap.actions.breakpoints_clear = dap.breakpoints_clear

M.dap.actions.repl_toggle = dap.repl_toggle
M.dap.actions.console_toggle = dap.console_toggle

M.dap.actions.run = dap.run
M.dap.actions.run_last = dap.run_last
M.dap.actions.terminate = dap.terminate
M.dap.actions.pause = dap.pause


_G.mnvim.code = {}
_G.mnvim.code = M
