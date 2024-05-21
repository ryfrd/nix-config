{ pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./modules/fonts
    ./modules/beautification

    ./common
    ./features/dunst
    ./features/gtk
    ./features/hyprland
    ./features/kitty
    ./features/nvim/full
    ./features/qutebrowser
    ./features/scripts
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.everforest;

  beautification = {
    enable = true;
    width = "3";
    radius = "10";
    gap = "10";
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    jellyfin-media-player
    sxiv
    zathura
    mpv
    cava
    pulsemixer
    element-desktop
  ];

}
