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
  home.stateVersion = "23.05";


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    #Tools
    age
    bat
    bottom
    btop
    curl
    delta
    difftastic
    exa
    fd
    fluxcd
    fzf
    glow
    gnumake
    helix
    htop
    hyperfine
    jq
    k9s
    kubectl
    mkcert
    mtr
    nghttp2
    nil
    niv
    nix-prefetch-git
    nix-prefetch-github
    ripgrep
    spicetify-cli
    starship
    tmux
    unzip
    yq
    zoxide
    zsh
  ] ++ (lib.optionals stdenv.isDarwin [
    # Install specific programming helpers for work lappy
    black
    isort
    pylint
    bazel-buildtools
    nodePackages.prettier
    nodePackages.eslint
    terraform
    tflint
  ]);
    # Languages/Runtimes
    # clang
    # gcc
    # deno
    # go
    # nodejs-18_x
    # rustup
    # terraform
  # ];

  imports = [
    ./modules/zsh/zsh.nix
    ./modules/nvim/nvim.nix
    ./modules/helix/helix.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/tools.nix
  ];
}
