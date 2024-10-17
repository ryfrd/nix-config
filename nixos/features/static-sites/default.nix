{
  services.caddy.virtualHosts."dymc.win".extraConfig = ''
    root * /srv/blog
    file_server
  '';
}
