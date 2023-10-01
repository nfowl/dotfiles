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
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, helix, home-manager, flake-utils, ... } @ inputs:
  let
    mkHomeConfig = machineModule: system: home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
      };

      modules = [
        machineModule
      ];

      extraSpecialArgs = {
        inherit inputs system;
      };
    };
  in
  {
    homeConfigurations.personal = mkHomeConfig ./personal.nix "x86_64-linux";
    homeConfigurations.work = mkHomeConfig ./work.nix "aarch64-darwin";
    # devShells.${system}.default = pkgs.mkShell {
    #   buildInputs = [
    #     pkgs.niv
    #     pkgs.nix
    #     pkgs.jq
    #     pkgs.home-manager
    #   ];
    # };
  };
}
