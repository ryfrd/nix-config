{ pkgs, config, ... }:
let
  c = config.colorscheme.colors;
in
{
  xdg.configFile = {
    "qtile/config.py" = {
      source = ./config.py;
    };
    "qtile/vars.py" = {
      text = ''
        colors = {
          'background': '#${c.base00}',
          'foreground': '#${c.base07}',
          'accent': '#${c.base0E}',
        }

        font = '${config.fontProfiles.monospace.family}'
        font_size = 18

        border = 1
        margin = 10
      '';
    };
  };
}

