{ config,  ... }: 
let

  c = config.colorScheme.palette;

  wid = config.beautificationVals.width;
  rad = config.beautificationVals.radius; 
  gap = config.beautificationVals.gap;

in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "${gap}x${gap}";
        font = "${config.fontProfiles.monospace.family} 12";
        frame_width = "${wid}";
        frame_color = "#${c.base03}";
        corner_radius = "${rad}";
        background = "#${c.base00}";
        foreground = "#${c.base05}";
      };
    };
  };
}
