{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd

    ./hardware/keep.nix

    ./base
    ./docker
    ./power

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "keep";
  networking.firewall = {
    allowedTCPPorts = [ 
    ];
    allowedUDPPorts = [ 22000 ];
  };

  # enable compression on btrfs root and mount
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/mnt/warhead".options = [ "compress=zstd" ];
  };

  # cron jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@monthly      root     sh /etc/cron-jobs/btrfs-maintenance.sh"
      "@weekly      root     sh /etc/cron-jobs/backup.sh /mnt/warhead/docs /mnt/warhead/pics /home/james/docker"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/btrfs-maintenance.sh" = {
      source = ./jobs/btrfs-maintenance.sh;
    };
    "cron-jobs/backup.sh" = {
      source = ./jobs/backup.sh;
    };
  };

}

