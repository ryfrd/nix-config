{ lib, config, pkgs, hardware, jovian, ... }: {

  imports = [

    hardware.nixosModules.lenovo-thinkpad-t14
    ./hardware/console.nix

    jovian.nixosModules.default
    ./common
    ./features/ssh/lowkey

  ];

  networking.hostName = "console";

  nixpkgs.config.allowUnfree = true; # for steam

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # time zone
  time.timeZone = "Europe/London";

  # locale
  i18n.defaultLocale = "en_GB.UTF-8";

  networking.networkmanager.enable = true;

  services.desktopManager.plasma6.enable = true;

  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "james";
    desktopSession = "plasma";
  };

}
