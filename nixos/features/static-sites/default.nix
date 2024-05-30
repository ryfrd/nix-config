{
  services.caddy.virtualHosts."wretched.place".extraConfig = ''
    root * /srv/blog
    file_server
  '';
}
