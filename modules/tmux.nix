{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "screen-256color";
    baseIndex = 1;
    extraConfig = ''
      bind z set -g status
      set -g terminal-overrides ",xterm-256color:RGB"
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      pain-control
      # {
      #   plugin = catppuccin;
      #   extraConfig = ''
      #     set -g terminal-overrides ",xterm-256color:RGB"
      #   '';
      # }
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-weather false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
          set -g @dracula-plugins "cpu-usage ram-usage time"
          set -g @dracula-military-time true

          bind z set -g status
        '';
      }
    ];
  };
}
