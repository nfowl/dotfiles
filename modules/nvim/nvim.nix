{ config, pkgs, ... }:
let 
  sources = (import ../../nix/sources.nix);
  # customVimPlugins = (import ./plugins.nix) pkgs;
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
        nvim-lspconfig
        cmp-nvim-lsp
        nvim-lint
        neogen
        # TODO(nfowl): One day go back and fix this to avoid installing everything
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-dap
        # DAPInstall
        fzf-vim
        telescope-nvim
        plenary-nvim
        telescope-live-grep-args-nvim
        telescope-fzf-native-nvim
        # folke/lua-dev
        luasnip
        cmp_luasnip
        # nvim-snippy
        # cmp-snippy
        # Color themes
        dracula-nvim
        tokyonight-nvim
        catppuccin-nvim
        # other
        gitsigns-nvim
        which-key-nvim
        flash-nvim
        dashboard-nvim
        bufferline-nvim
        nvim-cmp
        cmp-emoji
        cmp-path
        cmp-nvim-lsp-signature-help
        nvim-web-devicons
        SchemaStore-nvim
        nvim-autopairs
        nvim-ts-context-commentstring
        cmp-buffer
        FixCursorHold-nvim
        popup-nvim
        lualine-nvim
        nvim-notify
        toggleterm-nvim
        trouble-nvim
        open-browser-github-vim
        open-browser-vim
        oil-nvim
        mini-nvim
        mason-nvim
        mason-lspconfig-nvim
        conform-nvim
      ];
      extraConfig = ''
        lua << EOF
          ${builtins.readFile ./general.lua}
          ${builtins.readFile ./dash.lua}
        EOF
      '';
  };
}
