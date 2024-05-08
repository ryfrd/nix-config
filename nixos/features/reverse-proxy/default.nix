{
  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "audiobook.hog".locations."/".proxyPass = "http://127.0.0.1:8001";
      "kal.hog".locations."/".proxyPass = "http://127.0.0.1:8000";
      "jelly.hog".locations."/".proxyPass = "http://127.0.0.1:8096";
      "git.hog".locations."/".proxyPass = "http://127.0.0.1:3000";
      "pic.hog".locations."/".proxyPass = "http://127.0.0.1:2283";
      "music.hog".locations."/".proxyPass = "http://127.0.0.1:4533";
      "sync.hog".locations."/".proxyPass = "http://127.0.0.1:8384";
      "qbit.hog".locations."/".proxyPass = "http://127.0.0.1:8080";
      "prowl.hog".locations."/".proxyPass = "http://127.0.0.1:9696";
      "rdr.hog".locations."/".proxyPass = "http://127.0.0.1:7878";
      "snr.hog".locations."/".proxyPass = "http://127.0.0.1:8989";
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 ];

}
