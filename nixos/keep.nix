{ inputs, outputs, lib, config, pkgs, ... }:
let
  podDataDir = "/mnt/warhead/";
  podConfDir = "/srv/";
  srxPort = "8000";
  adPort = "8001";
  shelfPort = "8002";
  jellyPort = "8003";
  kavPort = "8004";
  naviPort = "8005";
  syncPort = "8006";
in
{

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

  environment.systemPackages = with pkgs; [ 
    docker-compose
  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "keep";
  networking.firewall = {
    allowedTCPPorts = [ 
      2049 # nfs server
      80 443 # nginx
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
  users.users.james.extraGroups = [ "docker" "podman" ];

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

  # proxies for docker services
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

    virtualHosts = {
      "qbit.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:3000";
	        proxyWebsockets = true;
	      };
      };

      "prowl.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:9696";
	        proxyWebsockets = true;
	      };
      };

      "rdr.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:7878";
	        proxyWebsockets = true;
	    };
      };

      "snr.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:8989";
	        proxyWebsockets = true;
	    };
      };
    };
  };

  # jellyfin
  services.jellfin = {
    enable = true;
  };
  services.nginx.virtualHosts."jelly.dymc.win" = {
    enableACME = true;
    acmeRoot = null;
    addSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
      proxyWebsockets = true;
	};
  };

  # kavita

  services.nginx.virtualHosts."kav.dymc.win" = {
    enableACME = true;
    acmeRoot = null;
    addSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${kavPort}";
      proxyWebsockets = true;
	};
  };

  # navidrome

  services.nginx.virtualHosts."navi.dymc.win" = {
    enableACME = true;
    acmeRoot = null;
    addSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${naviPort}";
      proxyWebsockets = true;
	};
  };

  # syncthing

  services.nginx.virtualHosts."sync.dymc.win" = {
    enableACME = true;
    acmeRoot = null;
    addSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${syncPort}";
      proxyWebsockets = true;
	};
  };

}

