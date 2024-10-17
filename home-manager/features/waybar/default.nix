{ config, pkgs, ... }:
let
  c = config.colorScheme.palette;
  wid = config.beautification.width;
  rad = config.beautification.radius;
  gap = config.beautification.gap;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "left";
        layer = "top";
        margin-left = 20;
        margin-top = 20;
        margin-bottom = 20;
        output = [ "eDP-1" ];
        modules-left = [ "hyprland/workspaces" ];
        # modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "battery" "backlight" "pulseaudio" "clock" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = " ";
            "6" = " ";
            "7" = " ";
            "8" = " ";
            "9" = " ";
          };
        };
        "battery" = {
          format = ''
            
            {}
          '';
        };
        "backlight" = {
          format = ''
            󰃠
            {}
          '';
        };
        "pulseaudio" = {
          format = ''
            
            {volume}
          '';
        };
        "clock" = {
          format = ''
            
            {:%H
            %M}
          '';
        };

      };
    };
    style = ''
      window#waybar {
        background: transparent;
        font-family: ${config.beautification.fontName};
      }

      #workspaces {
        background: #${c.base02};
        border-radius: ${rad};
        border: ${wid}px solid #${c.base06};
        padding: 2px;
      }
      #workspaces button {
        background: #${c.base00};
        color: #${c.base06};
        border-radius: ${rad};
        margin: 2px;
      }
      #workspaces button.active {
        padding-top: 10px;
        padding-bottom: 10px;
      }

      #battery {
        background: #${c.base00};
        color: #${c.base04};
        border-radius: ${rad};
      }
      #backlight {
        background: #${c.base00};
        color: #${c.base04};
        border-radius: ${rad};
      }
      #volume {
        background: #${c.base00};
        color: #${c.base04};
        border-radius: ${rad};
      }
      #clock {
        background: #${c.base00};
        color: #${c.base04};
        border-radius: ${rad};
      }

    '';
  };
}
