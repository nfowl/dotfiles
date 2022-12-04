{ pkgs, ... }:

{
    mason-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "mason.nvim";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "williamboman";
        repo = "mason.nvim";
        rev = "9d7058b1fb3bfa64e0f89ae77f3029f1a92b5878";
        sha256 = "1y1bw8bqg1ag7jpd37fzsyvppy3c3mqgfian8w82dcabwjkahyhs";
      };
    };
    mason-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "mason-lspconfig.nvim";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "williamboman";
        repo = "mason-lspconfig.nvim";
        rev = "edf15b98cd7d7ce0f83cf7d3a968145a3f974772";
        sha256 = "sha256:0lgv8l3yh289dj940497wf0985ckp0aaj7qbjx9kvp391rg2nxpi";
      };
    };
}
