{ pkgs, outputs, ... }: 
let
  name = "Agave";
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
      family = "${name} Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "${name}" ]; };
    };
  };
}
