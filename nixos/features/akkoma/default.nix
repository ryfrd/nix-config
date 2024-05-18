{
  services.postgresql.enable = true;

  services.akkoma = {
    enable = true;
    config = {
      ":pleroma" = {
        ":instance" = {
          name = "dymc.win";
          description = "humble single user instance";
          email = "jdysmcl@tutanota.com";
          registration_open = false;
        };
        "Pleroma.Web.Endpoint" = {
          url.host = "dymc.win";
          http.ip = "0.0.0.0";
          http.port = 4000;
        };
        "Pleroma.Upload" = {
          base_url = "https://media.dymc.win/media";
        };
      };
    };
  };

  services.caddy = {
    enable = true;
    extraConfig = ''
      dymc.win {
        reverse_proxy localhost:4000
        encode gzip zstd
      }
    '';
  };
}
