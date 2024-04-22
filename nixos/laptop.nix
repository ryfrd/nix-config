{ lib, config, pkgs, hardware, ... }: {

  imports = [

    hardware.nixosModules.lenovo-thinkpad-t14
    ./hardware/laptop.nix

    ./common
    ./features/nfs-client
    ./features/pipewire
    ./features/power
    ./features/steam
    ./features/syncthing
    ./features/virtualisation

  ];

  networking.hostName = "laptop";

  nixpkgs.config.allowUnfree = true; # for steam

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    firewall.allowedTCPPorts = [ 1313 5000 ];
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  # time zone
  time.timeZone = "Europe/London";

  # locale
  i18n.defaultLocale = "en_GB.UTF-8";

  programs.light.enable = true;
  users.users.james.extraGroups = [ "video" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.xserver.libinput.enable = true;

  hardware.opengl.enable = true;

  system.stateVersion = "22.11";

}
