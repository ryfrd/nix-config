{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    ./hardware/phalanx.nix

    ./base
    ./docker

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "phalanx";

  networking.firewall.allowedTCPPorts = [ 
    80 443 # web interface and file sharing
    5222 # client connections
    5269 # federation
    5000 # file transfer proxy
    3478 3479 # STUN/TURN
    5349 5350 # STUN/TURN TLS
  ];
  networking.firewall.allowedUDPPorts = [ 
    3478 3479 # STUN/TURN
    5349 5350 # STUN/TURN TLS
  ];
  # for TURN data
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 60000;
      to = 61023;
    }
  ];

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    ignoreIP = [ "countess" "baron" ]; # whitelist tailscale hosts
  };

  services.endlessh = {
    enable = true;
    openFirewall = true;
    port = 22;
  };

  # cron jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@weekly      root     sh /etc/cron-jobs/phalanx-backup.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/phalanx-backup.sh" = {
      source = ./jobs/phalanx-backup.sh;
    };
  };

  environment.systemPackages = with pkgs; [ rsync ];

}
