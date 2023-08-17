{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./cli
    ./de/qtile
    ./emacs
    ./dunst
    ./font
    ./gaming
    ./gtk/wm
    ./gui/wm
    ./kitty
    ./nvim/diy
    ./redshift

  ];

  colorscheme = inputs.nix-colors.colorschemes.onedark;

}
