{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nfowler";
  home.homeDirectory = "/Users/nfowler";
  imports = [
    ./home.nix
  ];
}
