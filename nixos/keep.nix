{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd

    ./hardware/keep.nix

    ./base
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

  # enable compression on mount
  fileSystems = {
    "/mnt/warhead".options = [ "compress=zstd" ];
  };

  # docker
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune.enable = true;
  };
  users.users.james.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [ 
    docker-compose
  ];

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
      "@daily      root     sh /etc/cron-jobs/pod-image-pull.sh"
      "@monthly      root     sh /etc/cron-jobs/btrfs-maintenance.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/pod-image-pull.sh" = {
      source = ./jobs/pod-image-pull.sh;
    };
    "cron-jobs/btrfs-maintenance.sh" = {
      source = ./jobs/btrfs-maintenance.sh;
    };
  };
}

