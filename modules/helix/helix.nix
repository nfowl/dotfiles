{ config, pkgs, ... }:
let 
  sources = (import ../../nix/sources.nix);
in
{
  xdg.configFile."helix/runtime/queries/cloudflare/highlights.scm".source = sources.tree-sitter-cloudflare + "/queries/highlights.scm";
  xdg.configFile."helix/config.toml".source = ./config.toml;
  xdg.configFile."helix/languages.toml".source = ./languages.toml;
}
