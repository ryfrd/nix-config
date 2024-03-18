{ lib, config, pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./common

  ];

  colorscheme = nix-colors.colorschemes.everforest;

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = DP-3,1920x1080@144,0x0,1
  '';

}
