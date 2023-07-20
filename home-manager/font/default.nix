{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.fonts ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Inconsolata Nerd Font";
      package = pkgs.inconsolata;
    };
    regular = {
      family = "Inconsolata Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; };
    };
  };
}
