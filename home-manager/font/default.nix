{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.fonts ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "ProggyClean Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "ProggyClean" ]; };
    };
    regular = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
  };
}
