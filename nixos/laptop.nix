{ lib, config, pkgs, hardware, ... }: {

  imports = [

    hardware.nixosModules.lenovo-thinkpad-t14
    ./hardware/laptop.nix

    ./common
    ./features/fonts
    ./features/nfs-client
    ./features/power
    ./features/pipewire
    ./features/steam

  ];

  networking.hostName = "laptop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    #firewall.allowedTCPPorts = [  ];
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

  services.libinput.enable = true;

  hardware.graphics.enable = true;

  services.fwupd.enable = true;

  programs.dconf.enable = true;

  system.stateVersion = "22.11";

}
