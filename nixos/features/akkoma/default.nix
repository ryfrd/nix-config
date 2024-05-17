{
  services.postgresql.enable = true;
  services.akkoma = {
    enable = true;
    config = {
      ":pleroma" = {
        ":instance" = {
          name = "exuberant.men";
          description = "humble single user instance";
          email = "jdysmcl@tutanota.com";
          registration_open = false;
        };
        "Pleroma.Web.Endpoint" = {
          url.host = "exuberant.men";
        };
      };
    };
  };

  services.caddy = {
    enable = true;
    extraConfig = ''
      exuberant.men {
        reverse_proxy localhost:4000
        encode gzip zstd
      }
    '';
  };
}
