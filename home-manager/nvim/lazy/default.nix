{ config, pkgs, lib, ... }:
let
  c = config.colorscheme.colors;
in
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
    fortune
    wl-clipboard
    xclip
  ];

  xdg = {
    enable = true;
    configFile."nvim" = {
      recursive = true;
      source = ./src;
    };
    configFile."nvim/lua/plugins/scheme.lua" = {
      text = ''
        return {
          {
            "RRethy/nvim-base16",
            lazy = false,
            priority = 1000,
            config = function()
                require('base16-colorscheme').setup({
                base00 = '#${c.base00}';
                base01 = '#${c.base01}';
                base02 = '#${c.base02}';
                base03 = '#${c.base03}';
                base04 = '#${c.base04}';
                base05 = '#${c.base05}';
                base06 = '#${c.base06}';
                base07 = '#${c.base07}';
                base08 = '#${c.base08}';
                base09 = '#${c.base09}';
                base0A = '#${c.base0A}';
                base0B = '#${c.base0B}';
                base0C = '#${c.base0C}';
                base0D = '#${c.base0D}';
                base0E = '#${c.base0E}';
                base0F = '#${c.base0F}';
              })
              end,
          },
          {
            "LazyVim/LazyVim",
              opts = {
                colorscheme = "default",
              },
          }
        }
      '';
    };
  };
}
