-- Treesitter config
require("nvim-treesitter.configs").setup{
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
    "sql",
    "svelte",
    "toml",
    "typescript",
    "tsx",
    "yaml",
  },
  sync_install = false,
}

-- LSP config
require("nvim-lsp-installer").setup{
  automatic_installation = true,
}

local lspconfig = require("lspconfig")
lspconfig.ansiblels.setup{}
lspconfig.bashls.setup{}
lspconfig.ccls.setup{}
lspconfig.cssls.setup{}
lspconfig.denols.setup{}
lspconfig.dockerls.setup{}
lspconfig.golangci_lint_ls.setup{}
lspconfig.gopls.setup{}
lspconfig.graphql.setup{}
lspconfig.jdtls.setup{}
lspconfig.jsonls.setup{}
lspconfig.marksman.setup{}
lspconfig.pyright.setup{}
lspconfig.rnix.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.sqlls.setup{}
lspconfig.sumneko_lua.setup{}
lspconfig.tailwindcss.setup{}
lspconfig.terraformls.setup{}
lspconfig.tsserver.setup{}
lspconfig.yamlls.setup{}


-- Keybindings
