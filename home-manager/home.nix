{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nfowler";
  home.homeDirectory = "/home/nfowler";
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = [
    #Tools
    pkgs.age
    pkgs.antibody
    pkgs.bat
    pkgs.delta
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    pkgs.gnumake
    pkgs.htop
    pkgs.jq
    pkgs.k9s
    # pkgs.neovim
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.unzip
    pkgs.zoxide
    pkgs.zsh
    # Languages/Runtimes
    pkgs.clang
    pkgs.deno
    pkgs.go
    pkgs.nodejs-18_x
    pkgs.rustup
    pkgs.terraform
  ];

  programs.neovim = {
    enable = true;
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
      in [
        #Vim plugins
        pkgs.vimPlugins.packer-nvim
        pkgs.vimPlugins.nvim-lspconfig
        #nlsp-settings
        #nvim-lsp-installer
        mason-nvim
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.null-ls-nvim
        pkgs.vimPlugins.nvim-treesitter
        #nvim-treesitter-playground
        pkgs.vimPlugins.nvim-dap
        #DAPInstall
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.plenary-nvim
        #live-grep-raw
        pkgs.vimPlugins.telescope-fzf-native-nvim
        pkgs.vimPlugins.rust-tools-nvim
        #folke/lua-dev
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.cmp_luasnip
        pkgs.vimPlugins.dracula-nvim
        pkgs.vimPlugins.tokyonight-nvim
        pkgs.vimPlugins.gitsigns-nvim
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.bufferline-nvim
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.cmp-emoji
        pkgs.vimPlugins.cmp-path
        pkgs.vimPlugins.cmp-nvim-lsp-signature-help
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.SchemaStore-nvim
        pkgs.vimPlugins.nvim-autopairs
        pkgs.vimPlugins.alpha-nvim
        pkgs.vimPlugins.nvim-ts-context-commentstring
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.FixCursorHold-nvim
        pkgs.vimPlugins.popup-nvim
        pkgs.vimPlugins.lualine-nvim
        pkgs.vimPlugins.nvim-notify
        pkgs.vimPlugins.toggleterm-nvim
        pkgs.vimPlugins.open-browser-vim
        pkgs.vimPlugins.open-browser-github-vim
        pkgs.vimPlugins.vim-surround
      # pkgs.vimPlugins.vim-doge
      ];
  };

  programs.zsh = {
    enable = true;
    # initExtra = ''
    #   # . ~/workspace/dotfiles/zsh/.zshrc
    # '';
    # envExtra = ''
    #   # . ~/workspace/dotfiles/zsh/.zshenv
    # '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
        '';
      }
    ];
  };
}
