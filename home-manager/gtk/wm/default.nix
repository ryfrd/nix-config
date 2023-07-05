{ config, pkgs, inputs, ... }:
let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
rec
{
  gtk = {
    enable = true;
    font = {
      name = "Agave Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Agave" ]; });
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
}

