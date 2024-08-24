{ config, pkgs, ... }:
let
  nodePacks = (pkgs.callPackage ./packages/node/default.nix {});
in
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
  # TODO(nfowl): Make this finer grained
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    #Tools
    age
    ast-grep
    bat
    bottom
    btop
    curlHTTP3
    cloudflared
    delta
    difftastic
    eza
    fd
    fluxcd
    fzf
    glow
    gnumake
    htop
    hyperfine
    jq
    k3d
    k6
    k9s
    kubectl
    lua-language-server
    mkcert
    mtr
    nghttp2
    niv
    nix-prefetch-git
    nix-prefetch-github
    node2nix
    rename
    ripgrep
    spicetify-cli
    sslscan
    starship
    tokei
    tmux
    unzip
    yq
    zellij
    zoxide
    zsh
    # Language Servers
    # Kept to the generic languages to avoid polluting overall
    # state with various languages
    # TODO(nfowl): Work out how many of these should stay here
    nil
    efm-langserver
    taplo
    jdt-language-server
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    pyright
    pnpm_8
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript-language-server
    nodePackages.eslint
    marksman
    clang-tools
    ruff
    isort
  ] ++ (lib.optionals stdenv.isDarwin [
    # Install specific programming helpers for work lappy
    # Too lazy to setup overall nix shells
    cmake
    deno
    pylint
    bazel-buildtools
    bazel-watcher
    bazelisk
    bun
    poetry
    terraform
    terraform-ls
    tflint
    golangci-lint
    gopls
    nodePacks."@canva/prettier"
    go_1_21
    darwin.libiconv
    nodejs_20
    wasm-pack
  ]) ++ (lib.optionals stdenv.isLinux [
    # Try to avoid rustup on personal device
    cargo
    # Use standard prettier for personal devices
    nodePackages.prettier
  ]);

  imports = [
    ./modules/alacritty.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/tools.nix
    ./modules/helix/helix.nix
    ./modules/nvim/nvim.nix
    ./modules/zsh/zsh.nix
  ];
}
