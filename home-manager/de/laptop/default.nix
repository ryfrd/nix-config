{ pkgs, inputs, config, ... }:
let

  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;
  ac = config.colorscheme.colors.base0E;

  border_width = "0";
  border_radius = "0";

  gap_in = "0";
  gap_out = "0";

  font = "Agave Nerd Font";
  font_size = "12";
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.packages = with pkgs; [ playerctl brightnessctl pamixer swaybg wofi ];

  xdg.configFile."hypr/hyprland.conf" = {
    text = ''
      monitor = eDP-1, 1920x1080@60,0x0,1 

      exec-once = swaybg -m fill -i ~/pics/wallpapers/sand.jpg
      exec-once = waybar

      general {
          gaps_in = ${gap_in}
          gaps_out = ${gap_out}
          border_size = ${border_width}
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
          rounding = ${border_radius}

          blur = true
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = true

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3

          active_opacity = 1.0
          inactive_opacity = 1.0
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

      bind = $mainMod, right, exec, pamixer -i 5
      bind = $mainMod, left, exec, pamixer -d 5

      bind = $mainMod, up, exec, brightnessctl set +5%
      bind = $mainMod, down, exec, brightnessctl set 5%-


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

  xdg.configFile."wofi/style.css" = {
    text = ''
                  window {
                      font-family: ${font} ${font_size};
      	            background-color: #${bg};
                      border-radius: ${border_radius}px;
                      border: ${border_width}px solid #${ac};
                      margin:0px;
                  }

                  #input {
                      margin: 5px;
                      border: none;
                      color: #${fg};
                      background-color: #${bg};
                  }

                  #inner-box {
                      margin: 5px;
                      border: none;
                      background-color: transparent;
                  }

                  #outer-box {
                      margin: 5px;
                      border: none;
                      background-color: transparent;
                  }

                  #text {
                      margin: 5px;
                      border: none;
                      color: #${fg};
                  }

                  #entry {
                      border: none;
                  }

                  #entry:focus {
                      border: none;
                  }

                  #entry:selected {
                      color: #${ac};
                      background-color: #${bg};
                      border-radius: 0px;
                      border: none;
                  }
    '';
  };

  xdg.configFile."wofi/config" = {
    text = ''
      allow-images=true
      allow-markup=true
      filter_rate=100
      insensitive=true
      show=drun
      width=400
      height=300
      hide_scroll=true
      prompt=work hard play hard
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        #margin-top = ${gap_size};
        #margin-left = ${gap_size};
        #margin-right = ${gap_size};
        #margin-bottom = 0;
        output = [ "eDP-1" ];

        modules-left = [
          "wlr/workspaces"
        ];
        modules-right = [
          "battery"
          "backlight"
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
        border: ${border_width}px solid #${ac};
        border-radius: ${border_radius}px;
        font-family: ${font};
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
        border-radius: ${border_radius}px;
        border-top: ${border_width}px solid #${ac};
        border-bottom: ${border_width}px solid #${ac};
        border-left: 0px;
        border-right: 0px;
        padding-left:10px;
        padding-right:10px;
        margin-left:4px;
        margin-right:4px;
      }
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "${font} ${font_size}";
        offset = "${gap_out}x${gap_out}";
        corner_radius = "${border_radius}";
        frame_width = "${border_width}";
        frame_color = "#${ac}";
        background = "#${bg}";
        foreground = "#${fg}";
      };
    };
  };
}
