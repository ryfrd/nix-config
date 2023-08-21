{ pkgs, ... }: {
<<<<<<< HEAD
=======

>>>>>>> 6eff877596cd3e5479a10e801cb0ba7f5a73f377
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "jdysmcl@tutanota.com";
      dnsProvider = "cloudflare";
      credentialsFile = "/etc/nixos/cloudflare.env";
    };
  };

  networking.firewall.allowedTCPPorts = [ 
    80 443 # nginx
    53 68 # dns + dhcp
    3000 8123 # web ui
  ];
  networking.firewall.allowedUDPPorts = [ 
    53 67 68 # dns + dhcp
  ];

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "dns.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
          proxyWebsockets = true;
        };
      };

      "home.dymc.win" = {
        enableACME = true;
        acmeRoot = null;
        addSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8123";
          proxyWebsockets = true;
        };
      };
    };
  };
}
