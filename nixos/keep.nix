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

  environment.systemPackages = with pkgs; [ 
    docker-compose
    # cron job deps
    gotify-cli
    smartmontools
  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "keep";
  networking.firewall = {
    # syncthing ports
    allowedTCPPorts = [ 
      22000 21027 # syncthing
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
  users.users.james.extraGroups = [ "docker" ];

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
      "@daily      root     sh /etc/cron-jobs/docker-backup.sh"
      "@weekly      root     sh /etc/cron-jobs/smart.sh"
      "@monthly      root     sh /etc/cron-jobs/btrfs-maintenance.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/docker-backup.sh" = {
      source = ./jobs/docker-backup.sh;
    };
    "cron-jobs/smart.sh" = {
      source = ./jobs/smart.sh;
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

      "kav.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:4000";
	        proxyWebsockets = true;
	      };
      };

      "jelly.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:5000";
	        proxyWebsockets = true;
	      };
      };

      "navi.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:6000";
	        proxyWebsockets = true;
	      };
      };

      "sync.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:7000";
	        proxyWebsockets = true;
	      };
      };

      "prism.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:8000";
	        proxyWebsockets = true;
	      };
      };

      "shelf.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:9000";
	        proxyWebsockets = true;
	      };
      };

      "gtfy.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:10000";
	        proxyWebsockets = true;
	      };
      };

      "srx.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
	        proxyPass = "http://127.0.0.1:11000";
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

  # nixos containers
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
  };

  containers.media-container = {
    autoStart = true;
    enableTun = true;
    bindMounts = {
      "/film" = "/mnt/warhead/media/film";
      "/tv" = "/mnt/warhead/media/tv";
      "/jelly-config" = "~/docker/active/jellyfin/config";
    };
    config = { pkgs, ... }: {
      services.tailscale.enable = true;
      virtualisation.oci-containers."jellyfin" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jellyfin:latest";
        ports = [
          "8096:8096"
        ];
        volumes = [
          "/film:/film"
          "/jelly-config:/config"
        ];
      }; 
    };
  };


}
