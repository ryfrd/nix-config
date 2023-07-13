{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-console
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gedit
    epiphany
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    simple-scan
    yelp
    gnome-maps
    gnome-font-viewer
  ]);

  programs.dconf.enable = true;
}
