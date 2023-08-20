{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.borders ];
  borderValues = {
    enable = true;
    width = "4";
    radius = "1";
    gap = "15";
  };
}
