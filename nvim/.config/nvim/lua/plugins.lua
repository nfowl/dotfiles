return require('packer').startup(function()
  -- Packer can manage itself
  use { "wbthomason/packer.nvim", }

  -- LSP Plugins
  use { "neovim/nvim-lspconfig", }
  use { "tamago324/nlsp-settings.nvim", }
  use { "jose-elias-alvarez/null-ls.nvim", }
  use { "williamboman/nvim-lsp-installer", }
  use { "nvim-treesitter/nvim-treesitter", }
  use { "hrsh7th/cmp-nvim-lsp", }
  use { "mfussenegger/nvim-dap", }
  use { "Pocco81/DAPInstall.nvim", }

  --- Telescope plugins
  use {
    "nvim-telescope/telescope.nvim",
    requires = { {'nvim-lua/plenary.nvim'} },
  }
  use { "nvim-telescope/telescope-live-grep-raw.nvim",}
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
  }

  -- Language Specific plugins
  use { "simrat39/rust-tools.nvim",}
  use { "folke/lua-dev.nvim", }
  use { "L3MON4D3/LuaSnip", }
  use { "saadparwaiz1/cmp_luasnip", }

  -- Colorscheme
  use { "dracula/vim", }

  -- Others
  use { "lewis6991/gitsigns.nvim", }
  use { "folke/which-key.nvim", }
  use { "akinsho/bufferline.nvim", }
  use { "hrsh7th/nvim-cmp", }
  use { "hrsh7th/cmp-path", }
  -- use { "kyazdani42/nvim-tree.lua", }
  use { "numToStr/Comment.nvim", }
  use { "kyazdani42/nvim-web-devicons", }
  use { "b0o/schemastore.nvim", }
  use { "windwp/nvim-autopairs", }
  use { "goolord/alpha-nvim", }
  use { "JoosepAlviste/nvim-ts-context-commentstring", }
  -- use { "ahmedkhalf/project.nvim", }
  use { "nvim-lua/plenary.nvim", }
  use { "hrsh7th/cmp-buffer", }
  use { "antoinemadec/FixCursorHold.nvim", } -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use { "nvim-lua/popup.nvim", }
  -- use { "Tastyep/structlog.nvim", }
  -- use { "rafamadriz/friendly-snippets", }
  use { "nvim-lualine/lualine.nvim", }
  use { "rcarriga/nvim-notify", }
  use { "akinsho/toggleterm.nvim", }

  use { "tyru/open-browser-github.vim", requires = {{"tyru/open-browser.vim",}},}
  use { "kkoomen/vim-doge",}
end)
