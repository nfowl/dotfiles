{ config, pkgs, inputs, system, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  
  home.file.".fdignore".source = ./.fdignore;
  home.file.".ideavimrc".source = ./.ideavimrc;
  xdg.configFile."fzf/fzf.zsh".source = "${pkgs.fzf}/share/fzf/key-bindings.zsh";
  xdg.configFile."zellij/config.kdl".source = ./zellij.kdl;

  programs.git = {
    enable = true;
    # difftastic = {
    #   enable = true;
    #   background = "dark";
    # };
    ignores = [
      ".factorypath"
      ".settings/"
      ".classpath"
      ".project"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
    themes = {
      tokyonight = {
        src = pkgs.fetchFromGitHub {
          owner = "enkia";
          repo = "enki-theme"; # Bat uses sublime syntax for its themes
          rev = "0b629142733a27ba3a6a7d4eac04f81744bc714f";
          sha256 = "sha256-Q+sac7xBdLhjfCjmlvfQwGS6KUzt+2fu+crG4NdNr4w=";
        };
        file = "/scheme/Enki-Tokyo-Night.tmTheme";
      };
      dracula = {
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        };
        file = "/Dracula.tmTheme";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
}
