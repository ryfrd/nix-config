{ pkgs, outputs, ... }: 
let
  name = "Monofur";
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
      family = "Fira Regular";
      package = pkgs.fira;
    };
  };
}
