{ pkgs, ... }:
let sources = import ../../nix/sources.nix; in 
{
    mason-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "mason.nvim";
      version = "main";
      src = sources.mason;
    };

    mason-lspconfig = pkgs.vimUtils.buildVimPlugin {
      pname = "mason-lspconfig.nvim";
      version = "main";
      src = sources.mason-lspconfig;
    };

    gitsigns = pkgs.vimUtils.buildVimPlugin {
      pname = "gitsigns.nvim";
      version = "main";
      src = sources.gitsigns-nvim;
    };
    
    tree-sitter-cloudflare = pkgs.callPackage
      (sources.nixpkgs + /pkgs/development/tools/parsing/tree-sitter/grammar.nix) {} {
      language = "cloudflare";
      version = "main";
      source = sources.tree-sitter-cloudflare;
    };

    conform = pkgs.vimUtils.buildVimPlugin {
      pname = "conform.nvim";
      version = "master";
      src = sources.conform-nvim;
    };
    
}
