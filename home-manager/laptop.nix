{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [

    outputs.homeManagerModules.fonts
    outputs.homeManagerModules.borders
    inputs.nix-colors.homeManagerModules.default

    ./common

  ];

  borderValues = {
    enable = true;
    width = "2";
    radius = "0";
    gap = "30";
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
    regular = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
  };

  colorscheme = inputs.nix-colors.colorschemes.tokyo-night-dark;

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = eDP-1,1920x1080@60,0x0,1
    exec-once = hyprctl keyword device:synps/2-synaptics-touchpad:enabled false
  '';

}
