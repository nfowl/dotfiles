{ config, pkgs, ...}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      colors = {
        # TokyoNight Alacritty Colors
        primary = {
          background = "#24283b";
          foreground = "#c0caf5";
        };

        #[colors.cursor]
        #cursor = "#c0caf5"
        #text = "#24283b"

        # Normal colors
        normal ={
          black = "#1d202f";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };

        # Bright colors
        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };

        # Indexed Colors
        indexed_colors = [
          {
            index = 16;
            color = "#ff9e64";
          }
          {
            index = 17;
            color = "#db4b4b";
          }
        ];

        ## Dracula
        # primary = {
        #   background = "#282a36";
        #   foreground = "#f8f8f2";
        #   bright_foreground = "#ffffff";
        # };
        # cursor = {
        #   text = "#282a36";
        #   cursor = "#f8f8f2";
        # };
        # vi_mode_cursor = {
        #   text = "CellBackground";
        #   cursor = "CellForeground";
        # };
        # selection = {
        #   text = "CellForeground";
        #   background = "#44475a";
        # };
        # normal = {
        #   black = "#21222c";
        #   red = "#ff5555";
        #   green = "#50fa7b";
        #   yellow = "#f1fa8c";
        #   blue = "#bd93f9";
        #   magenta = "#ff79c6";
        #   cyan = "#8be9fd";
        #   white = "#f8f8f2";
        # };
        # bright = {
        #   black = "#6272a4";
        #   red = "#ff6e6e";
        #   green = "#69ff94";
        #   yellow = "#ffffa5";
        #   blue = "#d6acff";
        #   magenta = "#ff92df";
        #   cyan = "#a4ffff";
        #   white = "#ffffff";
        # };
        # footer_bar = { 
        #   background = "#282a36";
        #   foreground = "#f8f8f2"; 
        # };
        #
        # hints.start ={ 
        #   foreground = "#282a36";
        #   background = "#f1fa8c"; 
        # };
        #
        # hints.end = {
        #   foreground = "#f1fa8c";
        #   background = "#282a36";
        # };
        # search = {
        #   matches = { 
        #     foreground = "#44475a";
        #     background = "#50fa7b"; 
        #   };
        #   focused_match = { 
        #     foreground = "#44475a";
        #     background = "#ffb86c"; 
        #   };
        # };
      };
    };
  };
}
