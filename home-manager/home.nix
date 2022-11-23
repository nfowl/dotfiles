{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "nfowler";
  # home.homeDirectory = "/home/nfowler";
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
  home.packages = with pkgs; [
    #Tools
    age
    antibody
    bat
    delta
    exa
    fd
    fzf
    gnumake
    htop
    jq
    k9s
    kubectl
    ripgrep
    starship
    tmux
    unzip
    zoxide
    zsh
    # Languages/Runtimes
    # clang
    # gcc
    # deno
    # go
    # nodejs-18_x
    # rustup
    # terraform
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

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
          ${builtins.readFile ../nvim/.config/nvim/lua/nfowl/general.lua}
          ${builtins.readFile ../nvim/.config/nvim/lua/nfowl/dash.lua}
        EOF
      '';
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
    themes = {
      tokyonight = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "enkia";
        repo = "enki-theme"; # Bat uses sublime syntax for its themes
        rev = "0b629142733a27ba3a6a7d4eac04f81744bc714f";
        sha256 = "sha256-Q+sac7xBdLhjfCjmlvfQwGS6KUzt+2fu+crG4NdNr4w=";
      } + "/scheme/Enki-Tokyo-Night.tmTheme");
      dracula = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime"; # Bat uses sublime syntax for its themes
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      } + "/Dracula.tmTheme");
    };
  };

  home.file.".zsh_plugins.txt".source = ../zsh/.zsh_plugins.txt;
  home.file.".fdignore".source = ../fd/.fdignore;
  home.file.".zkbd/xterm-256color-apple-darwin20.0".source = ../zsh/.zkbd/xterm-256color-apple-darwin20.0;
  home.file.".zkbd/xterm-256color-ubuntu-linux-gnu".source = ../zsh/.zkbd/xterm-256color-ubuntu-linux-gnu;

  programs.zsh = {
    enable = true;
    # defaultKeymap = "vicmd";
    history = {
      save = 50000;
    };
    profileExtra = ''
      if [[ -f ~/.zshrc ]]; then
        . ~/.zshrc
      fi
      if [[ -f ~/.zshenv ]]; then
        . ~/.zshenv
      fi
    '';
    shellAliases = {
      cat = "bat";
    };

    initExtraBeforeCompInit = ''
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle :compinstall filename '$HOME/.zshrc'
    '';

    initExtra = ''
      setopt appendhistory nomatch notify
      unsetopt beep
      ${builtins.readFile ./zkbd.sh}
      
      source <(antibody init)
      antibody bundle < ~/.zsh_plugins.txt

      ### Prompt stuff
    '';
    envExtra = ''
      # Export Language Settings
      export LANG=en_US.UTF-8
      export LC_ALL=en_US.UTF-8

      ##### EXPORTS
      export EDITOR="vim"
      export ZSH_CACHE_DIR="$HOME/.zsh/cache"
      export FPATH="$FPATH:/$ZSH_CACHE_DIR/completions"
      export FZF_DEFAULT_COMMAND='fd --type file --hidden'

      ### Optional PATH additions based on availability
      if command -v go >/dev/null 2>&1; then
        export PATH=$PATH:/usr/local/go/bin
        export PATH="$PATH:$(go env GOPATH)/bin"
      fi
      
      if [ -f $HOME/.zshenv_private ]; then
       source $HOME/.zshenv_private
      fi

      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
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
    settings = {
      add_newline = true;
      line_break.disabled = true;

      memory_usage = {
        disabled = false;
        threshold = 80;
      };

      nodejs.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;

      git_status = {
        disabled = true;
        #Add more options and fix for monorepo 🙁
      };

      git_branch = {
        truncation_length = 20;
      };

      python = {
        format = "via [\${symbol}(\($virtualenv\) )]($style";
      };
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      pain-control
      {
        plugin = dracula;
        extraConfig = ''
          set -g base-index 1
          setw -g pane-base-index 1
          set -g terminal-overrides ",xterm-256color:RGB"
          set -g @dracula-show-battery false
          set -g @dracula-show-weather false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
        '';
      }
    ];
  };
}
