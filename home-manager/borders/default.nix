{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.borders ];
  borderValues = {
    enable = true;
    width = "4";
    radius = "0";
    gap = "0";
  };
}
