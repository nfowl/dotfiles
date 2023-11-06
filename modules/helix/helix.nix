{ config, pkgs, inputs, system, ... }:
let 
  sources = (import ../../nix/sources.nix);
in
{
  imports = [
    ./languages/python.nix
    ./languages/cloudflare.nix
    ./languages/webdev.nix
    ./languages/generic.nix
  ];
  
  programs.helix = {
    package = inputs.helix.packages.${system}.default;
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        soft-wrap.enable = true;
      };

      keys = {
        normal = {
          space = {
            f = "file_picker_in_current_directory";
            F = "file_picker";
            t = {
              i = ":toggle-option lsp.display-inlay-hints";
              a = ":toggle-option auto-format";
            };
            i = ":toggle-option lsp.display-inlay-hints";
          };
        };
      };
    };
  };
  
  xdg.configFile."helix/runtime/queries/cloudflare/highlights.scm".source = sources.tree-sitter-cloudflare + "/queries/highlights.scm";
  # xdg.configFile."helix/config.toml".source = ./config.toml;
  # xdg.configFile."helix/languages.toml".source = ./languages.toml;
}
