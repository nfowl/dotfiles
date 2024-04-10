{ config, pkgs, ...}:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      line_break.disabled = true;

      memory_usage = {
        disabled = false;
        threshold = 80;
      };

      rust.format = "via [$symbol($numver )]($style)";

      nodejs.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      package.disabled = true;

      nix_shell = {
        format = "$symbol";
        symbol = " ";  
      };

      git_status = {
        disabled = true;
        #Add more options and fix for monorepo 🙁
        style = "yellow";
        format = "([$conflicted$stashed$staged$deleted$renamed$modified$untracked$ahead_behind]($style) )";
        untracked = "🤷";
        stashed = "📦";
        modified = "!$count";
        staged = "[+$count](green)";
        renamed = "»$count";
        deleted = "[✘$count](bold red)";
      };

      git_branch = {
        truncation_length = 20;
      };

      python = {
        format = "via [\${symbol}(\($virtualenv\) )]($style)";
      };
    };
  };
}
