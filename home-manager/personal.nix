{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nfowler";
  home.homeDirectory = "/home/nfowler";
  imports = [
    ./home.nix
  ];
}
