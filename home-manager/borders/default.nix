{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.borders ];
  borderValues = {
    enable = true;
    width = "2";
    radius = "8";
    gap = "40";
  };
}
