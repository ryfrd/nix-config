{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.flags = [ "-a" ];
  };
  environment.systemPackages = [ pkgs.docker-compose ];
  users.users.james.extraGroups = [ "docker" ];
}
