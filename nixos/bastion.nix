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
    mutableSettings = true;
    openFirewall = false;
    settings = {
      bind_host = "0.0.0.0";
      bind_port = 3000;
      dns.parental_enabled = true;
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

  # let keep and phalanx in for rsync backup
  users.users."james".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdRRGO2jiXuFGoc42sEVGhLOuEwDj7PlXzj+jlMBxRu root@keep"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID14yuY/fsUC1cm/tpUlXXbR9KLQGrHhUR+WOZiRI2B6 root@phalanx"
  ];

}
