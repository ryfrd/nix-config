{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [

    ./hardware/desktop.nix

    ./common
    ./features/gaming
    ./features/nfs-client
    ./features/pipewire
    ./features/syncthing
    ./features/virtualisation

  ];

  networking.hostName = "desktop";

  nixpkgs.config.allowUnfree = true; # for steam

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    firewall.allowedTCPPorts = [ 1313 5000 ];
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  hardware.opengl.enable = true;

  system.stateVersion = "22.11";

}
