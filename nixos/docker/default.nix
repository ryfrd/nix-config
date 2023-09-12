{ pkgs, ... }: {

  # docker
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune.enable = true;
  };

  users.users.james.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [ 
    docker-compose
  ];

 }

