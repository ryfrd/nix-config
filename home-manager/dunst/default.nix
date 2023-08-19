{ pkgs, inputs, config, ... }:
let

  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;
  ac = config.colorscheme.colors.base0E;
  
  wid = config.borderValues.width;
  rad = config.borderValues.radius;
  gap = config.borderValues.gap;

  font = config.fontProfiles.monospace.family;

in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "${gap}x${gap}";
        font = "${font} 12";
        frame_width = "${wid}";
        frame_color = "#${ac}";
        corner_radius = "${rad}";
        background = "#${bg}";
        foreground = "#${fg}";
      };
    };
  };
}
