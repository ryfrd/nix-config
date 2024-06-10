{ pkgs, config, hardware, ... }: {

  imports = [

    hardware.nixosModules.common-cpu-intel
    hardware.nixosModules.common-pc-hdd
    hardware.nixosModules.common-pc-ssd
    ./hardware/homelab.nix

    ./common
    ./features/docker
    ./features/nfs-server
    ./features/power
    ./features/ssh/lowkey

  ];

  # latest kernel compatible with zfs module
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "f42e33e7";
  # import pool at boot
  boot.zfs.extraPools = [ "warhead" ];
  # automatic scrubbing
  services.zfs.autoScrub.enable = true;
  services.btrfs.autoScrub.enable = true;

  networking.hostName = "homelab";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # nfs admin

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily	root	sh /etc/cronjobs/backup.sh /warhead/high-prio"
      "@weekly root sh /etc/cronjobs/zpool.sh"
    ];
  };

  environment.etc = {
    "cronjobs/backup.sh" = { source = ./cronjobs/backup.sh; };
    "cronjobs/zpool.sh" = { source = ./cronjobs/zpool.sh; };
  };

  # cronjob deps
  environment.systemPackages = with pkgs; [ rsync curl ];

  # enable quicksync
  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver intel-compute-runtime ];
  };

}
