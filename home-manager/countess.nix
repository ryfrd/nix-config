{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.fonts
    outputs.homeManagerModules.borders

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./base
    ./de/hypr/countess.nix
    ./display

  ];

  borderValues = {
    enable = true;
    width = "3";
    radius = "0";
    gap = "20";
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "ComicShannsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "ComicShannsMono" ]; };
    };
    regular = {
      family = "ComicShannsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "ComicShannsMono" ]; };
    };
  };

  colorscheme = inputs.nix-colors.colorschemes.dracula;

}
