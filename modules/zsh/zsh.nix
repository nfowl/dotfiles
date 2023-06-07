{ config, pkgs, ... }:

{
  # home.file.".zsh_plugins.txt".source = ./.zsh_plugins.txt;
  home.file.".zkbd/xterm-256color-apple-darwin20.0".source = ./.zkbd/xterm-256color-apple-darwin20.0;
  home.file.".zkbd/xterm-256color-ubuntu-linux-gnu".source = ./.zkbd/xterm-256color-ubuntu-linux-gnu;

  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "ohmyzsh/ohmyzsh path:plugins/docker"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/docker-compose"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/git"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/kube-ps1"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/pip"; }
        { name = "# Was failing on WSL (DEBUG LATER)"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/python"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/golang"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/rust"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/fzf"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/npm"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/zsh-interactive-cd"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/sudo"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/bazel"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/aws"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/mvn"; }
        { name = "ohmyzsh/ohmyzsh path:plugins/terraform"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
      ];
    };
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
      
      # source <(antibody init)
      # antibody bundle < ~/.zsh_plugins.txt

      if [ -f $HOME/.zshrc_private ]; then
       source $HOME/.zshrc_private
      fi

      function gch() {
        if [ -z "$(git rev-parse --git-dir 2> /dev/null)" ]; then
          return
        fi 
        branch=$(git branch | fzf | tr -d '[:space:]')
        if [[ ! -z "$branch" ]]; then
          git checkout $branch
        fi
      }
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
