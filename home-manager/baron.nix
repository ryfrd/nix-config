{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.fonts
    outputs.homeManagerModules.borders

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./de/hypr/baron.nix
    ./gui

  ];

  borderValues = {
    enable = true;
    width = "2";
    radius = "10";
    gap = "20";
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "ProggyClean Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "ProggyClean" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };

  colorscheme = inputs.nix-colors.colorschemes.espresso;

}
