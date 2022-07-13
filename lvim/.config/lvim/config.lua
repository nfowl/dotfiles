--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
vim.opt.relativenumber = true
-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  -- Terraform ls struggles so bump up time to format
  timeout = 20000,
  -- Dprint handles these ones
  pattern = "*.go,*.tfvars,*.tf,*.py,*.rs,*.md"
}
lvim.colorscheme = "dracula"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

lvim.keys.normal_mode["ga"] = "<cmd>lua vim.lsp.buf.code_action()<CR>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["sT"] = {
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Raw Grep"
}
lvim.builtin.which_key.mappings["sF"] = {
  "<cmd>Telescope find_files hidden=true<cr>", "Hidden Search",
}

lvim.builtin.which_key.mappings["gn"] = {
  "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "New Worktree",
}
lvim.builtin.which_key.mappings["gw"] = {
  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Browse Worktree",
}
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "comment",
  "css",
  "dockerfile",
  "go",
  "gomod",
  "gowork",
  "graphql",
  "hcl",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "nix",
  "python",
  "rust",
  "svelte",
  "typescript",
  "tsx",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- Python formatters
  { command = "isort", filetypes = { "python" },
    args = { "--settings-file", "/Users/nfowler/work/canva/tools/build/python/py_formatter/isort.toml", } },
  { command = "black", filetypes = { "python" },
    args = { "--config", "/Users/nfowler/work/canva/tools/build/python/py_formatter/black.toml", } },
  -- Terraform formatters
  { command = "terraform_fmt", filetypes = { "terraform" }, },
  { command = "prettier", filetypes = { "graphql", }, },
  { command = "buildifier", },
  --   {
  --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "prettier",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--print-with", "100" },
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "typescript", "typescriptreact" },
  --   },
}

lvim.builtin.nvimtree.setup.view.width = 45

-- Add rust tools
-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "dracula/vim",
    config = function()
      vim.cmd [[colorscheme dracula]]
    end,
  },
  { "kkoomen/vim-doge", },
  { "nvim-telescope/telescope-live-grep-raw.nvim", },
  { "tyru/open-browser-github.vim", requires = { { "tyru/open-browser.vim", } }, },
  { "simrat39/rust-tools.nvim", },
  { "ThePrimeagen/git-worktree.nvim", },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- Additional settings
vim.g.dprint_format_on_save = 1
vim.g.doge_doc_standard_python = 'google'
-- require('rust-tools').setup({})

-- worktree config
require("telescope").load_extension("git_worktree")
