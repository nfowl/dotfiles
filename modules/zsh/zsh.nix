{ config, pkgs, ... }:
let
  sources = (import ../../nix/sources.nix);
in
{
  home.file.".zkbd/xterm-256color-apple-darwin20.0".source = ./.zkbd/xterm-256color-apple-darwin20.0;
  home.file.".zkbd/xterm-256color-ubuntu-linux-gnu".source = ./.zkbd/xterm-256color-ubuntu-linux-gnu;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "docker-compose"
        "git"
        "kube-ps1"
        "pip"
        "python"
        "golang"
        "rust"
        "fzf"
        "npm"
        "zsh-interactive-cd"
        "sudo"
        "bazel"
        "aws"
        "mvn"
        "terraform"
      ];
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = sources.zsh-autosuggestions; 
      }
      {
        name = "zsh-syntax-highlighting";
        src = sources.zsh-syntax-highlighting; 
      }
      {
        name = "zsh-completions";
        src = sources.zsh-completions; 
      }
      {
        name = "zsh-vi-mode";
        src = sources.zsh-vi-mode;
      }
    ];
    defaultKeymap = "vicmd";
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
      
      if [ -f $HOME/.zshrc_private ]; then
       source $HOME/.zshrc_private
      fi

      function gch() {
        if [ -z "$(git rev-parse --git-dir 2> /dev/null)" ]; then
          return
        fi 
        branch=$(git branch --verbose --sort=-committerdate | fzf | awk '{print $1}' | tr -d '[:space:]')
        if [[ ! -z "$branch" ]]; then
          git checkout $branch
        fi
      }
      zvm_after_init_commands+=('[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh')
    '';
    envExtra = ''
      # Export Language Settings
      export LANGUAGE=en_US.UTF-8
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
      if [ -f $HOME/.spicetify/spicetify ]; then
        export PATH=$PATH:$HOME/.spicetify/
      fi
      
      if [ -f $HOME/.zshenv_private ]; then
       source $HOME/.zshenv_private
      fi

      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
  };
}
