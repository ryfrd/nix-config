{ pkgs, ... }: {

  imports = [

    ./hardware/remotelab.nix

    ./common
    ./features/caddy
    ./features/headscale
    ./features/ssh/highkey
    ./features/static-sites

  ];

  networking.hostName = "remotelab";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  # limit size of system journal
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  system.stateVersion = "23.05";

}
