{ pkgs, config, ... }: {

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

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "6af7a00f";
  boot.zfs.extraPools = [ "warhead" ];

  # backup job deps
  environment.systemPackages = with pkgs; [ sanoid curl ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 2 * * 1 root  sh /etc/cronjobs/local-backup.sh" # two in the morning every monday
    ];
  };

  # link script to /etc
  environment.etc."cronjobs/local-backup.sh".source = ./cronjobs/local-backup.sh;

  # enable wake on lan
  networking.interfaces.enp1s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  system.stateVersion = "24.11";

}
