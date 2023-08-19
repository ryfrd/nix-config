{ pkgs, outputs, ... }: 
let
  name = "ProggyClean";
in
{
  imports = [ outputs.homeManagerModules.fonts ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "${name} Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "${name}" ]; };
    };
    regular = {
      family = "Agave Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Agave" ]; };
    };
  };
}
