{
  networking.firewall.allowedTCPPorts = [
    2049 # nfs v4
  ];
  services.nfs.server.enable = true;
  # managing specific shares imperatively eg. zfs set sharenfs="rw=@192.168.1.0/24"
}
