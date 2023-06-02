{ config, pkgs, ... }:
let
  c = config.colorscheme.colors;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "Agave Nerd Font";
        style = "Regular";
      };
      font.bold = {
        family = "Agave Nerd Font";
        style = "Bold";
      };
      font.italic = {
        family = "Agave Nerd Font";
        style = "Italic";
      };
      font.bold_italic = {
        family = "Agave Nerd Font";
        style = "Bold Italic";
      };
      font.size = 16;

      colors.primary = {
        background = "#${c.base00}";
        foreground = "#${c.base07}";
      };
      colors.normal = {
        black = "#${c.base01}";
        red =  "#${c.base08}";
        green =  "#${c.base0B}";
        yellow =  "#${c.base0A}";
        blue =  "#${c.base0D}";
        magenta =  "#${c.base0F}";
        cyan =  "#${c.base0C}";
        white =  "#${c.base06}";
      };
      colors.bright = {
        black =  "#${c.base00}";
        red =  "#${c.base09}";
        green =  "#${c.base02}";
        yellow =  "#${c.base03}";
        blue =  "#${c.base04}";
        magenta =  "#${c.base0E}";
        cyan =  "#${c.base05}";
        white =  "#${c.base07}";
      };
    };
  };
}


