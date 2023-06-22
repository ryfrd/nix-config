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
  ];

  xdg = {
    enable = true;
    configFile."nvim" = {
      recursive = true;
      source = ./src;
    };
  };
}
