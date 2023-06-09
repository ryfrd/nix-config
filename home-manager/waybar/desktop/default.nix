{ pkgs, config, ... }: 
  let
    bg = config.colorscheme.colors.base01;
    fg = config.colorscheme.colors.base06;
    ac = config.colorscheme.colors.base0F;
  in
{

programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;
        margin-bottom = 0;
        output = [ "DP-3" ];

        modules-left = [
          "wlr/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "clock"
        ];
        
        # modules
        "battery" = {
          format = "battery: {}%";
        };
        "backlight" = {
          device = "intel_backlight";
          format = "brightness: {percent}%";
        };
        "clock" = {
          format = "{:%H:%M}";
        };
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            active = "X";
            default = "0";
          };
        };
        "pulseaudio" = {
          format = "volume: {volume}%";
        };
      };
    };
    style = ''
      * {
      }
      window#waybar {
        background: #${bg};
        border: 0px solid #${ac};
        font-family: Agave Nerd Font;
      }
      #clock,
      #battery,
      #window,
      #backlight,
      #pulseaudio,
      #custom-music,
      #workspaces {
        background: #${bg};
        color: #${fg};
        border-radius: 0px;
        border: 0px solid #${ac};
        padding-left:10px;
        padding-right:10px;
        margin-left:4px;
        margin-right:4px;
      }
    '';
  };
  }
