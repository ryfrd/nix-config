{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./borders
    ./cli
    ./de/hypr
    ./dunst
    ./font
    ./gaming
    ./gtk/wm
    ./gui/wm
    ./kitty
    ./nvim/diy
    ./redshift
    ./syncthing
    ./wofi

  ];

  colorscheme = inputs.nix-colors.colorschemes.kanagawa;

}
