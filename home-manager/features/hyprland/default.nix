{ config, pkgs, ... }:
let

  c = config.colorScheme.palette;

  wid = config.beautificationVals.width;
  rad = config.beautificationVals.radius;
  gap = config.beautificationVals.gap;

in {

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

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
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;
        rounding = "${rad}";
        blur.enabled = true;
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgb(${c.base03})";
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      gestures = { workspace_swipe = false; };

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

        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

      ];

    };
  };
}
