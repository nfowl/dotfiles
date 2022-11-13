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
    pkgs.neovim
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
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
