{ config, ... }:
let

  c = config.colorScheme.palette;

  wid = config.beautification.width;
  rad = config.beautification.radius;
  gap = config.beautification.gap;

in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "${gap}x${gap}";
        font = "${config.beautification.fontName} 12";
        frame_width = "${wid}";
        frame_color = "#${c.base03}";
        corner_radius = "${rad}";
        background = "#${c.base00}";
        foreground = "#${c.base05}";
      };
    };
  };
}
