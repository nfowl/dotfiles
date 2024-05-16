-- Leader
vim.g.mapleader = " "

-- Colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme "tokyonight"

-- General config
-- Default tab settings
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
-- Show both absolute line and relative
vim.opt.relativenumber = true
vim.opt.number = true
-- Show yank contents via highlight
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]
local key_opts = { noremap = true, silent = true }
require('plenary.filetype').add_file('ft')

-- Workaround for installing in nix environment
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

-- CMP Settings
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = "nvim_lsp", },
    { name = "path", },
    { name = "buffer", },
    { name = "emoji", },
    { name = "treesitter", },
    { name = "luasnip", },
    { name = "nvim_lsp_signature_help", },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<Tab>"] = cmp.mapping(function()
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   end
    -- end, {
    --   "i",
    --   "s",
    -- }),
    -- ["<S-Tab>"] = cmp.mapping(function()
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   end
    -- end, {
    --   "i",
    --   "s",
    -- }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cloudflare = {
  install_info = {
    url = "https://github.com/nfowl/tree-sitter-cloudflare",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "cfrule",
}

-- Treesitter config
require("nvim-treesitter.configs").setup {
  parser_install_dir = parser_install_dir,
  -- Custom treesitters
  ensure_installed = { "cloudflare", },
  enable = true,
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      ["@error"] = "Error"
    }
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["ac"] = "@class.outer",
        ["av"] = "@class.outer",
        ["aa"] = "@assignment.outer",
        ["ai"] = "@assignment.inner",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      -- selection_modes = {
      --   ['@parameter.outer'] = 'v', -- charwise
      --   ['@function.outer'] = 'V', -- linewise
      --   ['@class.outer'] = '<c-v>', -- blockwise
      -- },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
}

vim.filetype.add({
  extension = {
    cfrule = 'cfrule'
  },
})

--- LSP config
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = { exclude = { "rnix-lsp", "rnix", "nil", "nil_ls" } },
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, key_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, key_opts)
vim.keymap.set('n', '<Leader>lk', vim.diagnostic.goto_prev, key_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, key_opts)
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, key_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, key_opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Shared keybindings
local on_attach = function(client, bufnr)
  -- Buffer options
  -- Used with wrapper to allow description with shared config
  local function buffer_opts(desc)
    local buf_opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    return buf_opts
  end

  -- Shared Keymaps
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buffer_opts("Go to declaration"))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buffer_opts("Go to definition"))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, buffer_opts("Hover"))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buffer_opts("Go to Implementation"))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buffer_opts("View Signature"))
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, buffer_opts("Add folder to workspace"))
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, buffer_opts("Remove workspace folder"))
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, buffer_opts("List workspace folders"))
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, buffer_opts("Go to type definition"))
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, buffer_opts("Rename symbol"))
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer_opts("Code Action"))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffer_opts("View references"))
  vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, buffer_opts("Format"))
end

vim.lsp.set_log_level("off")

local lspconfig = require("lspconfig")
lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.astro.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  on_attach = on_attach,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- lspconfig.denols.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     -- Overrides default root_dir to omit `.git` to allow only enabling when
--     -- a project is specifically for deno
--     -- This avoids weird behaviour when dealing with a node based project
--     root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
--   }
-- }

lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.golangci_lint_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.nil_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = false,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  -- root_dir = function(fname)
  --   return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
  --       util.path.dirname(fname)
  -- end
}
-- Done by rust-tools
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
          "use",
        },
      }
    }
  }
}
-- lspconfig.tailwindcss.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend(
      "force",
      new_config.settings.yaml.schemas or {},
      require("schemastore").yaml.schemas()
    )
  end,
  capabilities = capabilities,
  settings = {
    yaml = {
      validate = false,
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = {
        kubernetes = "*.{yaml,yml}",
      }
    }
  }
}

-- Nvim-lint setup
require('lint').linters_by_ft = {
  typescript = { 'eslint', },
  javascript = { 'eslint', }
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Conform.nvim setup
local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    terraform = { "terraform_fmt" },
    python = { "isort", "ruff_format" },
    typescript = { "prettier" },
    markdown = { "prettier" },
    json = { "prettier" },
    starlark = { "buildifier" },
    bazel = { "buildifier" },
    bzl = { "buildifier" },
    -- Experimental and need to work out if worth it
    -- toml = { "taplo" },
    -- lua = { "stylua" },
  },
  -- Longer timeout on terraform
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "terraform" then
      return { lsp_fallback = true, timeout_ms = 10000, }
    end
    return { lsp_fallback = true, }
  end,
  formatters = {
    ruff_format = {
      args = {
        "format",
        "--line-length=100",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
    },
    black = {
      prepend_args = {
        "--line-length=100",
      },
    },
    isort = {
      prepend_args = {
        "--profile", "google",
        "--line-length", "100",
        "--multi-line", "3",
        "--trailing-comma",
        "--use-parentheses",
        "--ensure-newline-before-comments",
      },
    }
  }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})

-- Telescope
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>F", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })
vim.keymap.set("n", "<leader>f",
  function() telescope.find_files({ find_command = { "fd", "-E", ".git", "-t", "f", }, hidden = true, }) end,
  { noremap = true, silent = true, desc = "Find Files(Hidden)", })
vim.keymap.set("n", "<leader>t", telescope.live_grep, { noremap = true, silent = true, desc = "Find Text", })
vim.keymap.set("n", "<leader>T", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { noremap = true, silent = true, desc = "Find Text (Raw)", })
vim.keymap.set("n", "<leader>b", telescope.buffers, { noremap = true, silent = true, desc = "Find Text", })
vim.keymap.set("n", "<leader>v", telescope.git_status, { noremap = true, silent = true, desc = "Find Changed Files", })
vim.keymap.set("n", "<leader>d", function() telescope.diagnostics({ bufnr = 0, }) end,
  { noremap = true, silent = true, desc = "Diagnostics (file)", })
vim.keymap.set("n", "<leader>D", function() telescope.diagnostics({ bufnr = nil, }) end,
  { noremap = true, silent = true, desc = "Diagnostics (workspace)", })

-- Plugin setup
require("bufferline").setup()
require('gitsigns').setup()
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 100,
  }
})
require('oil').setup()
require("mini.pairs").setup()
require("mini.files").setup()
require('mini.indentscope').setup()
require('mini.surround').setup()
require('mini.comment').setup {
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
}
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

require('notify').setup()
require('trouble')

-- doge
vim.g.doge_doc_standard_python = "google"
--
