{ pkgs, ... }: {

  imports = [

    ./hardware/backup.nix

    ./common
    ./features/ssh/lowkey

  ];

  networking.hostName = "backup";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";

  # limit size of system journal
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  system.stateVersion = "24.11";

}
