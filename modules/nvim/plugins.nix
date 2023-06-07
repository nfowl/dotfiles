{ pkgs, ... }:
let sources = import ../../nix/sources.nix; in 
{
    mason-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "mason.nvim";
      version = "main";
      src = sources.mason;
    };

    mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "mason-lspconfig.nvim";
      version = "main";
      src = sources.mason-lspconfig;
    };
    
    tree-sitter-cloudflare = pkgs.callPackage
      (sources.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {} {
      language = "cloudflare";
      version = "0.1.0";
      source = sources.tree-sitter-cloudflare;
    };
}
