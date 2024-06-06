{ pkgs, nix-colors, ... }: {
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
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.tokyo-night-dark;

  beautification = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "0";
    fontName = "Agave Nerd Font";
  };

  home.packages = with pkgs; [
    wl-clipboard
    watershot
    mpv
    cava
    jellyfin-media-player
    sublime-music
    sxiv
    zathura
    pulsemixer
    element-desktop
  ];

}
