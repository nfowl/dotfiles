{ config, pkgs, ... }:

{
  programs.helix = {
    settings = {
      editor.lsp = {
        display-inlay-hints = true;
      };
    };
    languages = {
      language = [{
        name = "rust";
        config = {
          inlayHints.bindingModeHints.enable = false;
          inlayHints.closingBraceHints.minLines = 10;
          inlayHints.closureReturnTypeHints.enable = "with_block";
          inlayHints.discriminantHints.enable = "fieldless";
          inlayHints.lifetimeElisionHints.enable = "skip_trivial";
          inlayHints.typeHints.hideClosureInitialization = false;
        };
      }];
    };
  };
}
