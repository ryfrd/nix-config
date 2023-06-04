{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune.enable = true;
  };
  environment.systemPackages = [ pkgs.docker-compose ];
  users.users.james.extraGroups = [ "docker" ];
}
