{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.fonts
    outputs.homeManagerModules.borders

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./cli
    ./de/hypr/countess.nix
    ./dunst
    ./gaming
    ./gtk/wm
    ./gui/wm
    ./kitty
    ./nvim/diy
    ./redshift
    ./syncthing
    ./wofi

  ];

  borderValues = {
    enable = true;
    width = "5";
    radius = "0";
    gap = "0";
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };

  colorscheme = inputs.nix-colors.colorschemes.everforest;

}
