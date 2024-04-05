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
    ./features/waybar
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.nord;

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

  beautificationVals = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "10";
  };

  home.packages = with pkgs; [
    profanity
    bitwarden-desktop
    jellyfin-media-player
    sxiv
    zathura
    mpv
    cava
    pulsemixer
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = eDP-1,1920x1080@60,0x0,1
    exec-once = hyprctl keyword device:synps/2-synaptics-touchpad:enabled false
  '';

}
