{ lib, config, pkgs, nix-colors, ... }:
let

  inherit (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;


  font = config.fontProfiles.regular.family;

in
rec {
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
    platformTheme.name = "gtk";
  };
}
