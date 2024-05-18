{ pkgs, ... }:{
  services.matrix-synapse = {
    enable = true;
    enableRegistrationScript = true;
    withJemalloc = true;
    settings = {
      server_name = "brutal.dance";
      public_baseurl = "https://matrix.brutal.dance:443";
      enable_registration = false;
      database = {
        name = "psycopg2";
        args = {
          host = "localhost";
          user = "synapse";
          password = "synapse";
          database = "synapse";
        };
      };
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "127.0.0.1" ];
          resources = [
            {
              compress = true;
              names = [ "client" "federation" ];
            }
          ];
          tls = false;
          type = "http";
          x_forwarded = true;
        }
      ];
    };
  };

  services.postgresql.enable = true;
  services.postgresql.initialScript = pkgs.writeText "synapse-init.sql" ''
    CREATE ROLE "synapse" WITH LOGIN PASSWORD 'synapse';
    CREATE DATABASE "synapse" WITH OWNER "synapse"
      TEMPLATE template0
      LC_COLLATE = "C"
      LC_CTYPE = "C";
  '';
  services.postgresqlBackup = {
    enable = true;
    databases = [ "synapse" ];
  };

  services.caddy = {
    extraConfig = ''
      brutal.dance {
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *
        respond /.well-known/matrix/server `{"m.server": "matrix.brutal.dance:443"}`
        respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://matrix.brutal.dance"}`
      }

      matrix.brutal.dance {
        reverse_proxy /_matrix/* localhost:8008
        reverse_proxy /_synapse/client/* localhost:8008
      }

    '';
  };
}
