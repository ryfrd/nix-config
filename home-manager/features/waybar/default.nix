{ config, pkgs, ... }:
let
  c = config.colorScheme.palette;
  wid = config.beautificationVals.width;
  rad = config.beautificationVals.radius; 
  gap = config.beautificationVals.gap;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        output = [
          "eDP-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ "battery" "backlight" "pulseaudio" "clock" ];

        "hyprland/workspaces" = {
	        format = "{icon}";
	        format-icons = {
		        active = "";
		        default =  "";
	        };
          persistent-workspaces = {
            "*" = 9;
          };
        };
        "battery" = {
          format = "bat: {}% |";
        };
        "backlight" = {
          format = "bri: {}% |";
        };
        "pulseaudio" = {
          format = "vol: {volume}% |";
        };
        "clock" = {
          format = "{:%H:%M} ";
        };

      };
    };
    style = ''
      window#waybar {
        background: #${c.base00};
        color: #${c.base05};
        border: ${wid}px solid #${c.base03};
        font-family: ${config.fontProfiles.monospace.family};
      }
      label.module {
        padding: 5px;
      }
      #workspaces button.empty {
        color: #${c.base03};
      }
    '';
  };
}
