{ pkgs, config, hardware, ... }: {

  imports = [

    hardware.nixosModules.common-cpu-intel
    hardware.nixosModules.common-pc-ssd
    ./hardware/homelab.nix

    ./common
    ./features/docker
    ./features/nfs-server
    ./features/power
    ./features/ssh/lowkey

  ];

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

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # enable quicksync
  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver intel-compute-runtime ];
  };

  services.sanoid = {
    enable = true;
    datasets = {
      "warhead/high-prio" = {
        autoprune = true;
        autosnap = true;
        recursive = true;
        hourly = 24;
        daily = 7;
        monthly = 12;
      };
    };
  };

  # let backup machine in
  users.users.james.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDiIb2W2Ydt5iFUUsjTAUlUynhRU9TdkQAtd2AdVReRr root@backup"
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily root  sh /etc/cronjobs/hetzner-backup.sh /warhead/high-prio"
      "0 1 * * 1 root  sh /etc/cronjobs/wake-up-backup.sh" # one in the morning every monday
    ];
  };

  environment.etc = {
    "cronjobs/hetzner-backup.sh" = { 
      source = ./cronjobs/hetzner-backup.sh;
    };
    "cronjobs/wake-up-backup.sh" = { 
      source = ./cronjobs/wake-up-backup.sh;
    };
  };

  # cronjob deps
  environment.systemPackages = with pkgs; [ rsync curl sanoid wol ];


  system.stateVersion = "23.11";

}
