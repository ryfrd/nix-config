{ config, pkgs, inputs, ... }: {
  gtk = {
    enable = true;
    font = {
      name = "Agave Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Agave" ]; });
    };
    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}

