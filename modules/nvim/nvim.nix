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
          version = "main";
          src = pkgs.fetchFromGitHub {
            owner = "williamboman";
            repo = "mason.nvim";
            rev = "9d7058b1fb3bfa64e0f89ae77f3029f1a92b5878";
            sha256 = "1y1bw8bqg1ag7jpd37fzsyvppy3c3mqgfian8w82dcabwjkahyhs";
          };
        };
        mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "mason-lspconfig.nvim";
          version = "main";
          src = pkgs.fetchFromGitHub {
            owner = "williamboman";
            repo = "mason-lspconfig.nvim";
            rev = "edf15b98cd7d7ce0f83cf7d3a968145a3f974772";
            sha256 = "sha256:0lgv8l3yh289dj940497wf0985ckp0aaj7qbjx9kvp391rg2nxpi";
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
