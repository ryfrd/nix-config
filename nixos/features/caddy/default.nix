{ lib, ... }: {
  services.caddy.enable = true;
  services.caddy.email = "jdysmcl@tutanota.com";
  #services.caddy.logFormat = lib.mkForce "level INFO";
  networking.firewall.allowedTCPPorts = [
    80 443 # http/s
  ];

}
