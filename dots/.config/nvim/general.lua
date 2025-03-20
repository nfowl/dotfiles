-- Colorscheme
vim.cmd.colorscheme "tokyonight"
-- Show yank contents via highlight
require('plenary.filetype').add_file('ft')

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

  --
  -- -- Shared Keymaps
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" })
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
  -- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, buffer_opts("Format"))
end

vim.lsp.set_log_level("off")

local lspconfig = require("lspconfig")

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
  root_dir = lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")
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

require('notify').setup()
