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
      2049 # nfs server
    ];
    allowedUDPPorts = [ 22000 ];
  };

  # enable compression on btrfs root
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  # enable compression on mount
  fileSystems = {
    "/mnt/warhead".options = [ "compress=zstd" ];
  };

  # nfs server
  fileSystems."/export/warhead" = {
    device = "/mnt/warhead";
    options = [ "bind" ];
  };
  services.nfs.server = {
    enable = true;
    # uses tailscale ip for client devices
    exports = ''
      /export   100.121.230.21(rw,fsid=0,no_subtree_check)    100.100.176.11(rw,fsid=0,no_subtree_check)
      /export/warhead   100.121.230.21(rw,nohide,insecure,no_subtree_check)   100.100.176.11(rw,nohide,insecure,no_subtree_check)
    '';
  };

  # cron jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@weekly      root     sh /etc/cron-jobs/keep-backup.sh"
      "@monthly      root     sh /etc/cron-jobs/btrfs-maintenance.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/keep-backup.sh" = {
      source = ./jobs/keep-backup.sh;
    };
    "cron-jobs/btrfs-maintenance.sh" = {
      source = ./jobs/btrfs-maintenance.sh;
    };
  };

  environment.systemPackages = with pkgs; [ rsync ];
}

