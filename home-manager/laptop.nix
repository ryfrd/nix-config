{ pkgs, nix-colors, firefox-addons, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./modules/beautification

    ./common
    ./features/dunst
    ./features/eww
    ./features/gtk
    ./features/hyprland
    ./features/kitty
    ./features/nvim/full
    ./features/qutebrowser
    ./features/scripts
    ./features/ssh-config
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.everforest;

  beautification = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "20";
    fontName = "Agave Nerd Font";
  };

  home.packages = with pkgs; [
    wl-clipboard
    watershot
    mpv
    cava
    jellyfin-media-player
    sxiv
    zathura
    pulsemixer
    element-desktop
  ];

  programs.firefox = {
    enable = true;
    profiles.james = {
      extensions = with firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        bitwarden
        consent-o-matic
        darkreader
      ];
      search = {
        default = "DuckDuckGo";
        engines = {
          "nix packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            definedAliases = [ "@np" ];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "nixos wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            definedAliases = [ "@nw" ];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
        force = true;
      };
      settings = { "extensions.autoDisableScopes" = 0; };
    };
  };

}
