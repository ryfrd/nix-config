{ pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./modules/beautification

    ./common
    ./features/dunst
    ./features/hyprland
    ./features/kitty
    ./features/qutebrowser
    ./features/nvim/full
    ./features/scripts
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.nord;

  beautification = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "0";
    fontName = "Agave Nerd Font";
  };

  home.packages = with pkgs; [
    # media player
    mpv
    # image viewer
    imv
    # pdf viewer
    zathura
    # audio fiddling
    pulsemixer
    # desktop admin
    jellyfin-media-player
    cava
    wl-clipboard
  ];

}
