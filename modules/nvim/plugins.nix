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
}
