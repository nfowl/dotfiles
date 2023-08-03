{
  description = "Home Manager configuration of Nathan Fowler";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        homeConfigurations.personal = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./personal.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
        homeConfigurations.work = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;


          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./work.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.bash
            pkgs.niv
            pkgs.nix
            pkgs.jq
            pkgs.home-manager
          ];
        };
      }
    );
}
