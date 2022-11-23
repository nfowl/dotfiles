{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    plugins = 
      let
        mason-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "mason.nvim";
          version = "master";
          src = pkgs.fetchFromGitHub {
            owner = "williamboman";
            repo = "mason.nvim";
            rev = "master";
            sha256 = "sha256-7Wgu726LSGywkO9itK2YmrBVuS0O9NY51de2sS31kDI=";
          };
        };
        mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "mason-lspconfig.nvim";
          version = "master";
          src = pkgs.fetchFromGitHub {
            owner = "williamboman";
            repo = "mason-lspconfig.nvim";
            rev = "master";
            sha256 = "sha256-NdTYAPCsAN2p6J+z/CwGUmRxF9MQFVw6F1GJU4a1PdQ=";
          };
        };
      in with pkgs.vimPlugins; [
        #Vim plugins
        packer-nvim
        nvim-lspconfig
        cmp-nvim-lsp
        null-ls-nvim
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        nvim-treesitter-textobjects
        # nvim-treesitter-playground
        nvim-dap
        # DAPInstall
        telescope-nvim
        plenary-nvim
        # live-grep-raw
        telescope-fzf-native-nvim
        rust-tools-nvim
        # folke/lua-dev
        luasnip
        cmp_luasnip
        dracula-nvim
        tokyonight-nvim
        gitsigns-nvim
        which-key-nvim
        bufferline-nvim
        nvim-cmp
        cmp-emoji
        cmp-path
        cmp-nvim-lsp-signature-help
        comment-nvim
        nvim-web-devicons
        SchemaStore-nvim
        nvim-autopairs
        alpha-nvim
        nvim-ts-context-commentstring
        cmp-buffer
        FixCursorHold-nvim
        popup-nvim
        lualine-nvim
        nvim-notify
        toggleterm-nvim
        open-browser-vim
        open-browser-github-vim
        vim-surround
        # vim-doge
        # Custom built
        mason-nvim
        mason-lspconfig
      ];
      extraConfig = ''
        lua << EOF
          ${builtins.readFile ./general.lua}
          ${builtins.readFile ./dash.lua}
        EOF
      '';
  };
}
