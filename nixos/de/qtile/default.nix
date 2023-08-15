{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager.defaultSession = "none+qtile";
    excludePackages = [ pkgs.xterm ];
  };
}

