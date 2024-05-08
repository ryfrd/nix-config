{

  containers.jellyfin = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    bindMounts = {
      "/mnt/tv" = {
        hostPath = "/warhead/low-prio/tv";
        isReadOnly = true;
      };
      "/mnt/films" = {
        hostPath = "/warhead/low-prio/films";
        isReadOnly = true;
      };
    };
    config = {
      services.jellyfin.enable = true;
      networking.firewall.allowedTCPPorts = [ 8096 ];
    };
  };

  services.nginx = {
    virtualHosts = {
      "telly.hog".locations."/".proxyPass = "http://192.168.100.11:8096";
    };
  };

}
