{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./cli/essential
    ./gtk/de
    ./gui/essential
    ./kitty
    ./nvim/lazy
    ./syncthing
    ./ssh-alias

  ];

  colorscheme = inputs.nix-colors.colorschemes.gruvbox-dark-soft;

}
