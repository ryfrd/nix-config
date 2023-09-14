{ pkgs, config, inputs, ... }:

# stuff i want with graphical environment

let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
  c = config.colorscheme.colors;
  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;
  ac = config.colorscheme.colors.base0E;
  wid = config.borderValues.width;
  rad = config.borderValues.radius;
  gap = config.borderValues.gap;
  font = config.fontProfiles.monospace.family;
in
rec {

  imports = [ ./nvim ];

  home.packages = with pkgs; [
    streamlink
    mpv
    jellyfin-media-player
    sublime-music
    gnome.nautilus
    pulsemixer
    playerctl
    pamixer
    cava
    wl-clipboard
    bitwarden
    dino
  ];

  services.syncthing.enable = true;



  # notifications
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "${gap}x${gap}";
        font = "${font} 12";
        frame_width = "${wid}";
        frame_color = "#${ac}";
        corner_radius = "${rad}";
        background = "#${bg}";
        foreground = "#${fg}";
      };
    };
  };

  # redshift
  services.redshift = {
    enable = true;
    latitude = 55.9;
    longitude = 4.3;
  };

  # gtk
  gtk = {
    enable = true;
    font = {
      name = "${font}";
      size = 12;
    };
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme { scheme = config.colorscheme; };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # terminal
  home.sessionVariables.TERMINAL = "kitty";
  programs.kitty = {
    enable = true;
    font = {
      name = "${font}";
      size = 14;
    };
    settings = {
      shell_integration = "no-rc";
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      enable_audio_bell = "no";
      confirm_os_window_close = 0;

      foreground = "#${c.base05}";
      background = "#${c.base00}";
      selection_background = "#${c.base05}";
      selection_foreground = "#${c.base00}";
      url_color = "#${c.base04}";
      cursor = "#${c.base05}";
      active_border_color = "#${c.base03}";
      inactive_border_color = "#${c.base01}";
      active_tab_background = "#${c.base00}";
      active_tab_foreground = "#${c.base05}";
      inactive_tab_background = "#${c.base01}";
      inactive_tab_foreground = "#${c.base04}";
      tab_bar_background = "#${c.base01}";
      color0 = "#${c.base00}";
      color1 = "#${c.base08}";
      color2 = "#${c.base0B}";
      color3 = "#${c.base0A}";
      color4 = "#${c.base0D}";
      color5 = "#${c.base0E}";
      color6 = "#${c.base0C}";
      color7 = "#${c.base05}";
      color8 = "#${c.base03}";
      color9 = "#${c.base08}";
      color10 = "#${c.base0B}";
      color11 = "#${c.base0A}";
      color12 = "#${c.base0D}";
      color13 = "#${c.base0E}";
      color14 = "#${c.base0C}";
      color15 = "#${c.base07}";
      color16 = "#${c.base09}";
      color17 = "#${c.base0F}";
      color18 = "#${c.base01}";
      color19 = "#${c.base02}";
      color20 = "#${c.base04}";
      color21 = "#${c.base06}";
    };
  };

  # launcher
  programs.wofi = {
    enable = true;
    settings = {
      insensitive=true;
      show="drun";
      width=400;
      height=300;
      hide_scroll=true;
      prompt="go>>";
    };
    style = ''
      window {
        font-family: ${font};
      	background-color: #${bg};
        border-radius: ${rad}px;
        border: ${wid}px solid #${ac};
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

  # web browser
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    searchEngines = {
      DEFAULT = "https://srx.dymc.win/search?q={}";
      ddg = "https://duckduckgo.com/?q={}";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      np = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      m = "https://www.openstreetmap.org/search?query={}";
    };
    settings = {
      url.start_pages = "file:///home/james/.config/qutebrowser/start.html";
      fonts = {
      #  default_family = "${font}";
        default_size = "13pt";
      };
      colors = {
        webpage = {
          preferred_color_scheme = config.colorscheme.kind;
          bg = "#ffffff";
        };
        completion = {
          fg = "#${c.base05}";
          match.fg = "#${c.base09}";
          even.bg = "#${c.base00}";
          odd.bg = "#${c.base00}";
          scrollbar = {
            bg = "#${c.base00}";
            fg = "#${c.base05}";
          };
          category = {
            bg = "#${c.base00}";
            fg = "#${c.base0D}";
            border = {
              bottom = "#${c.base00}";
              top = "#${c.base00}";
            };
          };
          item.selected = {
            bg = "#${c.base02}";
            fg = "#${c.base05}";
            match.fg = "#${c.base05}";
            border = {
              bottom = "#${c.base02}";
              top = "#${c.base02}";
            };
          };
        };
        contextmenu = {
          disabled = {
            bg = "#${c.base01}";
            fg = "#${c.base04}";
          };
          menu = {
            bg = "#${c.base00}";
            fg = "#${c.base05}";
          };
          selected = {
            bg = "#${c.base02}";
            fg = "#${c.base05}";
          };
        };
        downloads = {
          bar.bg = "#${c.base00}";
          error.fg = "#${c.base08}";
          start = {
            bg = "#${c.base0D}";
            fg = "#${c.base00}";
          };
          stop = {
            bg = "#${c.base0C}";
            fg = "#${c.base00}";
          };
        };
        hints = {
          bg = "#${c.base0A}";
          fg = "#${c.base00}";
          match.fg = "#${c.base05}";
        };
        keyhint = {
          bg = "#${c.base00}";
          fg = "#${c.base05}";
          suffix.fg = "#${c.base05}";
        };
        messages = {
          error.bg = "#${c.base08}";
          error.border = "#${c.base08}";
          error.fg = "#${c.base00}";
          info.bg = "#${c.base00}";
          info.border = "#${c.base00}";
          info.fg = "#${c.base05}";
          warning.bg = "#${c.base0E}";
          warning.border = "#${c.base0E}";
          warning.fg = "#${c.base00}";
        };
        prompts = {
          bg = "#${c.base00}";
          fg = "#${c.base05}";
          border = "#${c.base00}";
          selected.bg = "#${c.base02}";
        };
        statusbar = {
          caret.bg = "#${c.base00}";
          caret.fg = "#${c.base0D}";
          caret.selection.bg = "#${c.base00}";
          caret.selection.fg = "#${c.base0D}";
          command.bg = "#${c.base01}";
          command.fg = "#${c.base04}";
          command.private.bg = "#${c.base01}";
          command.private.fg = "#${c.base0E}";
          insert.bg = "#${c.base00}";
          insert.fg = "#${c.base0C}";
          normal.bg = "#${c.base00}";
          normal.fg = "#${c.base05}";
          passthrough.bg = "#${c.base00}";
          passthrough.fg = "#${c.base0A}";
          private.bg = "#${c.base00}";
          private.fg = "#${c.base0E}";
          progress.bg = "#${c.base0D}";
          url.error.fg = "#${c.base08}";
          url.fg = "#${c.base05}";
          url.hover.fg = "#${c.base09}";
          url.success.http.fg = "#${c.base0B}";
          url.success.https.fg = "#${c.base0B}";
          url.warn.fg = "#${c.base0E}";
        };
        tabs = {
          bar.bg = "#${c.base00}";
          even.bg = "#${c.base00}";
          even.fg = "#${c.base05}";
          indicator.error = "#${c.base08}";
          indicator.start = "#${c.base0D}";
          indicator.stop = "#${c.base0C}";
          odd.bg = "#${c.base00}";
          odd.fg = "#${c.base05}";
          pinned.even.bg = "#${c.base0B}";
          pinned.even.fg = "#${c.base00}";
          pinned.odd.bg = "#${c.base0B}";
          pinned.odd.fg = "#${c.base00}";
          pinned.selected.even.bg = "#${c.base02}";
          pinned.selected.even.fg = "#${c.base05}";
          pinned.selected.odd.bg = "#${c.base02}";
          pinned.selected.odd.fg = "#${c.base05}";
          selected.even.bg = "#${c.base02}";
          selected.even.fg = "#${c.base05}";
          selected.odd.bg = "#${c.base02}";
          selected.odd.fg = "#${c.base05}";
        };
      };
    };
  };

  xdg.configFile."qutebrowser/start.html" = {
    enable = true;
    text = ''
    <!DOCTYPE html>
    <html>
    <style>
    html,body {
      margin: 0;
      padding: 0;
      height: 100%;
      background-color: #${c.base01};
      color: #${c.base00};
      font-size: 16pt;
    }
    .text-container {
      display:flex;
      justify-content:center;
      align-items:center;
      height:100vh;
    }
    .text {
    }
    </style>
    </head>
    <body>
    <div class="text-container">
    <pre class="text">/_/______/___________________/ /________/ /___/  \</pre>
    </div>
    </body>
    </html>
    '';
  };

}
