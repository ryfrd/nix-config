{ pkgs, inputs, config, ... }:
let

  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;
  ac = config.colorscheme.colors.base0E;

  wid = config.borderValues.width;
  rad = config.borderValues.radius;
  gap = config.borderValues.gap;

in
{

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = false;

    settings = {

      general = {
        gaps_in = "${gap}";
        gaps_out = "${gap}";
        border_size = "${wid}";
        "col.active_border" = "rgb(${ac})";
        "col.inactive_border" = "rgb(${bg})";
      };

      dwindle.default_split_ratio = 1.08;

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;
        rounding = "${rad}";
        blur.enabled = true;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgb(${ac})";
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "'^(Kitty|Alacritty)$'";
      };

      gestures = {
        workspace_swipe = true;
      };

      exec-once = [
        "${pkgs.swaybg}/bin/swaybg -i ~/.background -m fill"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

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

          # media
          "SUPERSHIFT,right,exec,playerctl next"
          "SUPERSHIFT,left,exec,playerctl previous"
          "SUPERSHIFT,up,exec,playerctl play-pause"
          "SUPERSHIFT,down,exec,playerctl stop"
          
          # volume
          "SUPER,up,exec,pamixer -i 5 && dunstify volume $(pamixer --get-volume)"
          "SUPER,down,exec,pamixer -d 5 && dunstify volume $(pamixer --get-volume)"

          # brightness
          "SUPER,right,exec,light -A 5 && dunstify brightness $(light)"
          "SUPER,left,exec,light -U 5 && dunstify brightness $(light)"

          # info
          "SUPER,u,exec,dunstify battery $(cat /sys/class/power_supply/BAT0/capacity)"
          "SUPER,i,exec,dunstify backlight $(light)"
          "SUPER,o,exec,dunstify volume $(pamixer --get-volume)"
          "SUPER,p,exec,dunstify time $(date +'%H:%M')"

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

      monitor = "eDP-1, 1920x1080@60,0x0,1";
    };
  };
}
