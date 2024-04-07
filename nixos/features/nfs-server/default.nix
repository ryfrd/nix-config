{
  networking.firewall.allowedTCPPorts = [
    2049 # nfs v4
  ];
  services.nfs.server.enable = true;
}
