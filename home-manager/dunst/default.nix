{ pkgs, inputs, config, ... }:
let

  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;

  font = config.fontProfiles.monospace.family;

in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "${font} 12";
        frame_width = "0";
        background = "#${bg}";
        foreground = "#${fg}";
      };
    };
  };
}
