{ config, pkgs, ... }:
let

  c = config.colorScheme.palette;

  wid = config.beautification.width;
  rad = config.beautification.radius;
  gap = config.beautification.gap;

in {

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        path = "/home/james/.background";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        rounding = "${rad}";
        outline_thickness = "${wid}";
        font_color = "rgb(${c.base06})";
        inner_color = "rgb(${c.base00})";
        outer_color = "rgb(${c.base02})";
      }];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      device = {
        name = "synps/2-synaptics-touchpad";
        enabled = 0;
      };

      general = {
        gaps_in = "${gap}";
        gaps_out = "${gap}";
        border_size = "${wid}";
        "col.active_border" = "rgb(${c.base03})";
        "col.inactive_border" = "rgb(${c.base00})";
      };

      dwindle.default_split_ratio = 1.08;

      animations = { enabled = 1; };

      decoration = {
        active_opacity = 0.95;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        rounding = "${rad}";
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(${config.home.sessionVariables.TERMINAL})$";
      };

      exec-once = [ "${pkgs.swaybg}/bin/swaybg -i ~/.background -m fill" ];

      bindm = [ "SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow" ];

      bind = let

        terminal = config.home.sessionVariables.TERMINAL;
        editor = config.home.sessionVariables.EDITOR;
        launcher = "${config.programs.wofi.package}/bin/wofi";

      in [

        # quit
        "SUPERSHIFT,q,exit"

        # launch items
        "SUPER,Return,exec,${terminal}"
        "SUPER,e,exec,${terminal} -e ${editor}"
        "SUPER,d,exec,${launcher}"

        "SUPER,backspace,exec,hyprlock"

        # volume
        "SUPER,up,exec,pamixer -i 5"
        "SUPER,down,exec,pamixer -d 5"

        # brightness
        "SUPER,right,exec,light -A 5"
        "SUPER,left,exec,light -U 5"

        # info
        "SUPER,i,exec,sh /home/james/.config/scripts/info.sh"

        # windows
        "SUPER,q,killactive"
        "SUPER,f,fullscreen"
        "SUPERSHIFT,f,togglefloating"
        "SUPER,space,cyclenext"
        "SUPERSHIFT,space,swapnext"

        "SUPER,h,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,k,movefocus,u"
        "SUPER,j,movefocus,d"

        "SUPERSHIFT,h,swapwindow,l"
        "SUPERSHIFT,l,swapwindow,r"
        "SUPERSHIFT,k,swapwindow,u"
        "SUPERSHIFT,j,swapwindow,d"

        # workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"

        "SUPERSHIFT,1,movetoworkspace,1"
        "SUPERSHIFT,2,movetoworkspace,2"
        "SUPERSHIFT,3,movetoworkspace,3"
        "SUPERSHIFT,4,movetoworkspace,4"
        "SUPERSHIFT,5,movetoworkspace,5"
        "SUPERSHIFT,6,movetoworkspace,6"
        "SUPERSHIFT,7,movetoworkspace,7"
        "SUPERSHIFT,8,movetoworkspace,8"
        "SUPERSHIFT,9,movetoworkspace,9"

      ];

    };
  };
}
