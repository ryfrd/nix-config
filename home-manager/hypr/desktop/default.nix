{ pkgs, inputs, config, ... }:
let
  bg = config.colorscheme.colors.base01;
  fg = config.colorscheme.colors.base06;
  ac = config.colorscheme.colors.base0F;
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.packages = with pkgs; [ playerctl pamixer swaybg ];

  xdg.configFile."hypr/hyprland.conf" = {
    text = ''
    monitor = DP-3, 1920x1080@144,0x0,1 

    exec-once = swaybg -m fill -i ~/pics/wallpapers/skyplanet.jpg

    general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgb(${ac})  
        col.inactive_border = rgb(${bg})
        resize_on_border = true
        hover_icon_on_border = false
        layout = dwindle
    }

    dwindle {
        default_split_ratio = 1.05
    }

    decoration {
        rounding = 10

        blur = true
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = true

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3

        active_opacity = 1.0
        inactive_opacity = 0.9
        fullscreen_opacity = 1.0
    }

    misc {
        enable_swallow = true
        swallow_regex = ^(Alacritty)$

        disable_hyprland_logo = true
        disable_splash_rendering = true
    }

    $mainMod = SUPER

    bind = $mainMod, return, exec, alacritty
    bind = $mainMod, d, exec, wofi
    bind = $mainMod, e, exec, emacsclient -ca emacs

    bind = $mainMod, t, exec, dunstify "$(date)" 

    bind = $mainMod, right, exec, pamixer -i 5
    bind = $mainMod, left, exec, pamixer -d 5
    bind = $mainMod, v, exec, dunstify "volume: $(pamixer --get-volume)%" 

    bind = $mainMod SHIFT, right, exec, playerctl next
    bind = $mainMod SHIFT, left, exec, playerctl previous
    bind = $mainMod SHIFT, up, exec, playerctl play-pause
    bind = $mainMod SHIFT, down, exec, playerctl stop

    bind = $mainMod SHIFT, q, exit
    bind = $mainMod SHIFT, r, exec, hyprctl reload

    bind = $mainMod, f, fullscreen
    bind = $mainMod SHIFT, f, togglefloating
    bind = $mainMod, q, killactive
    bind = $mainMod, space, cyclenext
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, l, movefocus, r
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, j, movefocus, d

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10
    '';
  };
}


