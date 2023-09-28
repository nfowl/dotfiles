{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      ui.pane_frames.hide_session_name=true;
      default_layout = "compact";
      simplified_ui = true;
      theme = "catppuccin-macchiato";
      # themes.tokyonight = {
      #   fg=169 177 214;
      #   bg=36 40 59;
      #   black=56 62 90;
      #   red=249 51 87;
      #   green=158 206 106;
      #   yellow=224 175 104;
      #   blue=122 162 247;
      #   magenta=187 154 247;
      #   cyan=42 195 222;
      #   white=192 202 245;
      #   orange=255 158 100;
      # };
      themes."catppuccin-macchiato" = {
        bg="#5b6078";
        fg="#cad3f5";
        red="#ed8796";
        green="#a6da95";
        blue="#8aadf4";
        yellow="#eed49f";
        magenta="#f5bde6";
        orange="#f5a97f";
        cyan="#91d7e3";
        black="#1e2030";
        white="#cad3f5";
      };
    };    
  };
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
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-weather false
          set -g @dracula-refresh-rate 10
          set -g @dracula-plugins "time"
          set -g @dracula-military-time true

          bind z set -g status
        '';
      }
    ];
  };
}
