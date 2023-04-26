{ config, pkgs, ... }:
let 
  sources = (import ../../nix/sources.nix);
  customVimPlugins = (import ./plugins.nix) pkgs;
in
{
  xdg.configFile."nvim/queries/cloudflare/highlights.scm".source = sources.tree-sitter-cloudflare + "/queries/highlights.scm";
  xdg.configFile."nvim/data/plenary/filetypes/ft.lua".source = ./ft.lua;
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
        #Vim plugins
        packer-nvim
        nvim-lspconfig
        cmp-nvim-lsp
        null-ls-nvim
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-dap
        # DAPInstall
        telescope-nvim
        plenary-nvim
        # live-grep-raw
        telescope-fzf-native-nvim
        # rust-tools-nvim
        # folke/lua-dev
        luasnip
        cmp_luasnip
        # Color themes
        dracula-nvim
        tokyonight-nvim
        catppuccin-nvim
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
        customVimPlugins.mason-nvim
        customVimPlugins.mason-lspconfig
        customVimPlugins.nvim-treesitter-playground
      ];
      extraConfig = ''
        lua << EOF
          ${builtins.readFile ./general.lua}
          ${builtins.readFile ./dash.lua}
        EOF
      '';
  };
}
