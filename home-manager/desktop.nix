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
    gap = "50";
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

  colorscheme = inputs.nix-colors.colorschemes.everforest;

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = DP-3,1920x1080@144,0x0,1
  '';

}
