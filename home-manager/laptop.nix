{ pkgs, nix-colors, ... }: {
  imports = [

    nix-colors.homeManagerModules.default

    ./common

  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-soft;

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = eDP-1,1920x1080@60,0x0,1
    exec-once = hyprctl keyword device:synps/2-synaptics-touchpad:enabled false
  '';

}
