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
        output = [ "eDP-1" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ "battery" "backlight" "pulseaudio" "clock" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            #   "1" = "terminal";
            #   "2" = "edit";
            #   "3" = "work";
            #   "4" = "pw";
            #   "5" = "browser";
            #   "6" = "game";
            #   "7" = "watch";
            #   "8" = "talk";
            #   "9" = "listen";
            active = "x";
            default = "0";
          };
          persistent-workspaces = { "*" = 9; };
        };
        "battery" = {
          format = ''
            bat
            {}%
          '';
        };
        "backlight" = {
          format = ''
            bri
            {}%
          '';
        };
        "pulseaudio" = {
          format = ''
            vol
            {volume}%
          '';
        };
        "clock" = { format = "{:%H:%M}"; };

      };
    };
    style = ''
      window#waybar {
        background: #${c.base00};
        color: #${c.base05};
        border: ${wid}px solid #${c.base03};
        font-family: ${config.beautification.fontName};
      }
      label.module {
        padding: 5px;
      }
      #workspaces {
        font-size: 16;
      }
      #workspaces button.empty {
        color: #${c.base03};
      }
    '';
  };
}
