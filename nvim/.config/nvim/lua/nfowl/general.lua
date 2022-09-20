-- Leader
vim.g.mapleader = " "

-- Colorscheme
vim.opt.termguicolors = true
vim.cmd [[colorscheme tokyonight]]

-- General config
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]

local key_opts = { noremap = true, silent = true }
-- vim.keymap.set("n",)


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

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, key_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, key_opts)
vim.keymap.set('n', '<Leader>lk', vim.diagnostic.goto_prev, key_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, key_opts)
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, key_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, key_opts)

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
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- Needs to be high as terraform takes a while to format
local format_timeout = 10000
local util = require 'vim.lsp.util'
null_ls.setup({
    -- you can reuse a shared lspconfig on_attach callback here
    debug = true,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    local params = util.make_formatting_params({})
                    -- client.request("textDocument/formatting", params, nil, bufnr)
                    -- vim.lsp.buf.formatting_sync(nil, format_timeout)
                    local result, _ = client.request_sync("textDocument/formatting", params, format_timeout, bufnr)
                    if result and result.result then
                      util.apply_text_edits(result.result, bufnr, client.offset_encoding)
                    end
                end,
            })
        end
    end,
    -- sources
    sources = {
      -- Code Actions
      null_ls.builtins.code_actions.eslint,
      -- Diagnostics
      null_ls.builtins.diagnostics.eslint,
      -- Formatting
      null_ls.builtins.formatting.eslint,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.terraform_fmt.with({
        timeout = format_timeout
      }),
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.black.with({
        extra_args = { "--line-length=100", }
      }),
      null_ls.builtins.formatting.isort.with({
        extra_args = {
          "--profile", "google",
          "--line-length", "100",
          "--multi-line", "3",
          "--trailing-comma",
          "--use-parentheses",
          "--ensure-newline-before-comments"
        },
      })
    }
})


-- Telescope
require("telescope").setup()
require('telescope').load_extension('fzf')
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })
vim.keymap.set("n", "<leader>F", function() telescope.find_files({ hidden = true, }) end,
  { noremap = true, silent = true, desc = "Find Files(Hidden)", })
vim.keymap.set("n", "<leader>sF", telescope.find_files, { noremap = true, silent = true, desc = "Find Files", })
vim.keymap.set("n", "<leader>sf", function() telescope.find_files({ find_command = { "fd", "-E", ".git", "-t", "f", }, hidden = true, }) end,
  { noremap = true, silent = true, desc = "Find Files(Hidden)", })
vim.keymap.set("n", "<leader>st", telescope.live_grep, { noremap = true, silent = true, desc = "Find Text", })
vim.keymap.set("n", "<leader>sT", require('telescope').extensions.live_grep_args.live_grep_args,
  { noremap = true, silent = true, desc = "Find Text (Raw)", })
vim.keymap.set("n", "<leader>bf", telescope.buffers, { noremap = true, silent = true, desc = "Find Text", })
vim.keymap.set("n", "<leader>vf", telescope.git_status, { noremap = true, silent = true, desc = "Find Changed Files", })

-- Plugin setup
require("which-key").setup()
require("nvim-autopairs").setup()
require("bufferline").setup()
require('gitsigns').setup()
require('Comment').setup()
require('lualine').setup{
  options = {
    theme = 'tokyonight'
  }
}

-- dashboard
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = require("nfowl.dash")
require("alpha").setup(dashboard.config)

-- doge
vim.g.doge_doc_standard_python = "google"

--
