{ pkgs, ... }: {

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "jdysmcl@tutanota.com";
      dnsProvider = "cloudflare";
      credentialsFile = "/etc/nixos/cloudflare.env";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {

      "kal.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:2000";
          proxyWebsockets = true;
        };
      };

      "qbit.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
      	  proxyPass = "http://127.0.0.1:3000";
	        proxyWebsockets = true;
	      };
      };

      "up.dymc.win" = {
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

}
