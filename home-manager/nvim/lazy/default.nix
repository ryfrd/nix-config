{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # required by plugins
  home.packages = with pkgs; [
    gcc
    gnumake
    unzip
    cargo
    nodePackages.npm
  ];

  xdg = {
    enable = true;
    configFile."nvim" = {
      recursive = true;
      source = ./src;
    };
  };
}
