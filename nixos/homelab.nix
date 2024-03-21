{ pkgs, config, hardware, ... }: {

  imports = [

    hardware.nixosModules.common-cpu-intel
    hardware.nixosModules.common-pc-hdd
    hardware.nixosModules.common-pc-ssd
    ./hardware/homelab.nix

    ./common
    ./features/docker
    ./features/power
    ./features/ssh-server

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

  networking.firewall.allowedTCPPorts = [
    2049 # nfs v4
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # install some basic stuff for humans
  environment.systemPackages = with pkgs; [
    neovim
    git
    tree
    curl
    dua
    ranger
    rsync
    pfetch
    flac
    fastfetch
    shntool
    cuetools
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily	root	sh /etc/cronjobs/backup.sh /warhead/docs /warhead/pics /warhead/docker /warhead/games /warhead/music /warhead/sync"
    ];
  };

  environment.etc = {
    "cronjobs/backup.sh" = {
      source = ./cronjobs/backup.sh;
    };
  };

  hardware.opengl.enable = true;

  services.nfs.server = {
    enable = true;
    # managing specific shares imperatively eg. zfs set sharenfs="rw=@192.168.1.0/24"
  };

}
