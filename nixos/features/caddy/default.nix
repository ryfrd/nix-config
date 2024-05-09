{
  services.caddy.enable = true;
  services.caddy.email = "jdysmcl@tutanota.com";
  networking.firewall.allowedTCPPorts = [
    80 443 # http/s
  ];

}
