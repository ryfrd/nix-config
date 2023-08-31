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
    gnome.seahorse
    streamlink
    mpv
    jellyfin-media-player
    pulsemixer
    playerctl
    pamixer
    cava
    wl-clipboard
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
  programs.firefox = {
    enable = true;
    profiles.james = {
      isDefault = true;
      bookmarks = [
      ];
      search = {
        force = true;
        default = "DuckDuckGo";
        order = [
          "DuckDuckGo"
        ];
      };
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.maxRichResults" = 0;
        "browser.newtabpage.enabled" = true;
        "browser.startup.homepage" = "about:newtab";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topStories" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.newtabpage.pinned" = [
          {
            name = "gunners";
            url = "https://reddit.com/r/gunners";
          }
          {
            name = "github";
            url = "https://github.com";
          }
          {
            name = "hacker news";
            url = "https://news.ycombinator.com";
          }
          {
            name = "nix packages";
            url = "https://search.nixos.org";
          }
          {
            name = "guardian";
            url = "https://theguardian.com";
          }
          {
            name = "lobsters";
            url = "https://lobste.rs";
          }
          {
            name = "twitch";
            url = "https://twitch.tv";
          }
          {
            name = "nts";
            url = "https://nts.live";
          }
          {
            name = "rym";
            url = "https://rateyourmusic.com";
          }
          {
            name = "gft";
            url = "https://glasgowfilm.org";
          }
          {
            name = "osm";
            url = "https://openstreetmap.org";
          }
          {
            name = "lichess";
            url = "https://lichess.org";
          }
          {
            name = "sport";
            url = "https://bbc.co.uk/sport";
          }
          {
            name = "hltv";
            url = "https://hltv.org";
          }
          {
            name = "ebay";
            url = "https://ebay.co.uk";
          }
          {
            name = "yt";
            url = "https://youtube.com";
          }
        ];
        "browser.uiCustomization.state" = /* json */ ''
        {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar"],"currentVersion":19,"newElementCount":3}
        '';
      };
    };
  };


}
