{ pkgs, firefox-addons, ... }: {
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
