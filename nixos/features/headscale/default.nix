{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    settings = {
      server_url = "https://brutal.dance";
      db_type = "sqlite3";
      db_path = "/var/lib/headscale/db.sqlite";
    };
  };

  services.caddy = {
    enable = true;
    email = "jdysmcl@tutanota.com";
    extraConfig = ''
      brutal.dance {
        reverse_proxy localhost:8080
      }
    '';
  };

  networking.firewall.allowedUDPPorts = [ 3478 ];

}
