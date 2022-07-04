-- Leader
vim.g.mapleader = " "

-- Colorscheme
vim.opt.termguicolors = true
vim.g.dracula_colorterm = 0
vim.cmd('colorscheme dracula')

-- General config
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- CMP Settings
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = "nvim_lsp", },
    { name = "path", },
    { name = "buffer", },
    { name = "emoji", },
    { name = "treesitter", },
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

-- Treesitter config
require("nvim-treesitter.configs").setup {
  ensure_installed = {
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
    "toml",
    "typescript",
    "tsx",
    "yaml",
  },
  context_commentstring = {
    enable = true,
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- LSP config
require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>lk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, buffer_opts("Go to type definition"))
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, buffer_opts("Rename symbol"))
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer_opts("Code Action"))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffer_opts("View references"))
  vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, buffer_opts("Format"))
end

local lspconfig = require("lspconfig")
lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Broken
-- lspconfig.ccls.setup {
--   on_attach = on_attach,
-- }
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- conflicts with tsserver
-- lspconfig.denols.setup {
--   on_attach = on_attach,
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
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.rnix.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.sumneko_lua.setup {
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
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
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
  capabilities = capabilities,
}

-- Null-ls

-- Telescope

require("telescope").setup()
require('telescope').load_extension('fzf')
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })
vim.keymap.set("n", "<leader>F", function() telescope.find_files({ hidden = true, }) end,
  { noremap = true, silent = true, desc = "Find Files(Hidden)", })
vim.keymap.set("n", "<leader>sf", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })
vim.keymap.set("n", "<leader>sF", function() telescope.find_files({ hidden = true, }) end,
  { noremap = true, silent = true, desc = "Find Files(Hidden)", })
vim.keymap.set("n", "<leader>st", telescope.live_grep, { noremap = true, silent = true, desc = "Find Text", })
vim.keymap.set("n", "<leader>sT", require('telescope').extensions.live_grep_args.live_grep_args,
  { noremap = true, silent = true, desc = "Find Text (Raw)", })
vim.keymap.set("n", "<leader>bf", telescope.buffers, { noremap = true, silent = true, desc = "Find Text", })
-- vim.keymap.set("n", "<leader>sf", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })

-- Plugin setup
require("which-key").setup()
require("nvim-autopairs").setup()
require("bufferline").setup()
require('gitsigns').setup()

-- dashboard
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = require("dash")
require("alpha").setup(dashboard.config)

--
