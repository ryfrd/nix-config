{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.flags = [ "-a" ];
    daemon.settings = { dns = [ "1.1.1.1" ];};
  };
  environment.systemPackages = [ pkgs.docker-compose ];
  users.users.james.extraGroups = [ "docker" ];
}
