{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        markup = "none";
        font = "Agave Nerd Font 12";
        offset = "10x10";
        corner_radius = 10;
        frame_width = 2;
        frame_color = "#${config.colorscheme.colors.base0F}"; 
        background = "#${config.colorscheme.colors.base01}";
        foreground = "#${config.colorscheme.colors.base05}";
      };
    };
  };
}
