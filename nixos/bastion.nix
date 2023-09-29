{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-pc-ssd

    ./hardware/bastion.nix

    ./base
    ./power

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "bastion";
  networking.firewall = {
    allowedTCPPorts = [ 
      80 443 # nginx
      53 3000 # adguardhome
    ];
    allowedUDPPorts = [ 53 ];
  };

  # enable compression on btrfs root
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    openFirewall = false;
    settings = {
      bind_host = "0.0.0.0";
      bind_port = 3000;
      dns.parental_enabled = false;
    };
  };

  # proxy for adguardhome ui
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "jdysmcl@tutanota.com";
      dnsProvider = "cloudflare";
      credentialsFile = "/etc/nixos/cloudflare.env";
    };
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."ad.dymc.win" = {
      enableACME = true;
      acmeRoot = null;
      addSSL = true;
      locations."/" = {
	    proxyPass = "http://127.0.0.1:3000";
	    proxyWebsockets = true;
	  };
    };
  };

  # backup job
  # grabs important items from keep and phalanx
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@weekly      root     sh /etc/cron-jobs/backup.sh"
    ];
  };

  # link script to etc
  environment.etc = {
    "cron-jobs/backup.sh" = {
      source = ./jobs/backup.sh;
    };
  };

  # backup deps
  environment.systemPackages = with pkgs; [ rsync ];

}
