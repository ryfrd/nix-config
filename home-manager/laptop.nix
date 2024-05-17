{ pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./modules/fonts
    ./modules/beautification

    ./common
    ./features/dunst
    ./features/gtk
    ./features/helix
    ./features/hyprland
    ./features/kitty
    ./features/nvim/bones
    ./features/qutebrowser
    ./features/scripts
    ./features/wofi

  ];

  colorScheme = nix-colors.colorSchemes.nord;

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


    nodePackages.pyright
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = eDP-1,1920x1080@60,0x0,1
    exec-once = hyprctl keyword device:synps/2-synaptics-touchpad:enabled false
  '';

}
