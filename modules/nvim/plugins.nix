{ pkgs, ... }:
let sources = import ../../nix/sources.nix; in 
{
    tree-sitter-cloudflare = pkgs.callPackage
      (sources.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {} {
      language = "cloudflare";
      version = "main";
      source = sources.tree-sitter-cloudflare;
    };

    # Example vim plugin from source
    # conform = pkgs.vimUtils.buildVimPlugin {
    #   pname = "conform.nvim";
    #   version = "master";
    #   src = sources.conform-nvim;
    # };
    
}
