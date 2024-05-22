{ pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./modules/fonts
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

  colorScheme = nix-colors.colorSchemes.black-metal;

  beautification = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "10";
  };

  fontProfiles = let font = "Agave";
  in {
    enable = true;
    monospace = {
      family = "${font} Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "${font}" ]; };
    };
    regular = {
      family = "${font} Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "${font}" ]; };
    };
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
