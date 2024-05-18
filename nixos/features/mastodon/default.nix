{ lib, pkgs, ... }: {
  services.mastodon = {
    enable = true;
    localDomain = "exuberant.men";
    smtp.fromAddress = ""; # Email address used by Mastodon to send emails, replace with your own
    extraConfig.SINGLE_USER_MODE = "true";
    streamingProcesses = 1;
    mediaAutoRemove = {
      enable = true;
      olderThanDays = 1;
      startAt = "hourly";
    };
  };
  services.caddy.virtualHosts = {
    "exuberant.men" = {
      extraConfig = ''
        handle_path /system/* {
          file_server * {
            root /var/lib/mastodon/public-system
          }
        }

        handle /api/v1/streaming/* {
          reverse_proxy  unix//run/mastodon-streaming/streaming.socket
        }

        route * {
          file_server * {
            root ${pkgs.mastodon}/public
            pass_thru
          }
          reverse_proxy * unix//run/mastodon-web/web.socket
        }

        handle_errors {
          root * ${pkgs.mastodon}/public
          rewrite 500.html
          file_server
        }

        encode gzip

        header /* {
          Strict-Transport-Security "max-age=31536000;"
        }
        header /emoji/* Cache-Control "public, max-age=31536000, immutable"
        header /packs/* Cache-Control "public, max-age=31536000, immutable"
        header /system/accounts/avatars/* Cache-Control "public, max-age=31536000, immutable"
        header /system/media_attachments/files/* Cache-Control "public, max-age=31536000, immutable"
      '';
    };
  };

  # Caddy requires file and socket access
  users.users.caddy.extraGroups = [ "mastodon" ];

  # Caddy systemd unit needs readwrite permissions to /run/mastodon-web
  systemd.services.caddy.serviceConfig.ReadWriteDirectories = lib.mkForce [ "/var/lib/caddy" "/run/mastodon-web" ];
}

