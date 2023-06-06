{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        markup = "none";
        font = "Agave Nerd Font 12";
        offset = "10x10";
        corner_radius = 0;
        frame_width = 0;
        frame_color = "#${config.colorscheme.colors.base0F}"; 
        background = "#${config.colorscheme.colors.base01}";
        foreground = "#${config.colorscheme.colors.base05}";
      };
    };
  };
}
