{ config, pkgs, ... }:

{
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
    nix-prefetch-git
    nix-prefetch-github
    # Languages/Runtimes
    # clang
    # gcc
    # deno
    # go
    # nodejs-18_x
    # rustup
    # terraform
  ] ++ lib.optionals stdenv.isLinux [
    # TODO(nfowl): Migrate off this due to deprecation 
    antibody
  ];

  imports = [
    ./modules/zsh/zsh.nix
    ./modules/nvim/nvim.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/tools.nix
  ];
}
