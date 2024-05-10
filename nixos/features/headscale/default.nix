{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    settings = {
      server_url = "https://hs.dymc.win";
      db_type = "sqlite3";
      db_path = "/var/lib/headscale/db.sqlite";
    };
  };

  services.caddy = {
    extraConfig = ''
      hs.dymc.win {
        reverse_proxy localhost:8080
      }
    '';
  };

  networking.firewall.allowedUDPPorts = [ 3478 ];

}
