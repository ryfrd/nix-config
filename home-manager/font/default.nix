{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.fonts ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Monofur Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Monofur" ]; };
    };
    regular = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
  };
}
