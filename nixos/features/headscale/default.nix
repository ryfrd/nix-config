{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    settings = {
      server_url = "https://pickle.brutal.dance";
      db_type = "sqlite3";
      db_path = "/var/lib/headscale/db.sqlite";
    };
  };

  services.caddy = {
    extraConfig = ''
      pickle.brutal.dance {
        reverse_proxy localhost:8080
      }
    '';
  };

  networking.firewall.allowedUDPPorts = [ 3478 ];

}
