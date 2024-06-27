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
    ./features/ssh-config
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.everforest;

  beautification = {
    enable = true;
    width = "2";
    radius = "10";
    gap = "10";
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

}
