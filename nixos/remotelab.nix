{ pkgs, ... }: {

  imports = [

    ./hardware/remotelab.nix

    ./common
    ./features/caddy
    ./features/headscale
    ./features/mastodon
    ./features/ssh/highkey
    ./features/static-sites
    ./features/synapse

  ];

  networking.hostName = "remotelab";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  services.cron = {
    enable = true;
    systemCronJobs =
      [ "@daily	root	sh /etc/cronjobs/backup.sh /home/james/phalanx-docker" ];
  };

  environment.etc = {
    "cronjobs/backup.sh" = { source = ./cronjobs/backup.sh; };
  };

  # cronjob deps
  # required system wide as jobs run as root
  environment.systemPackages = with pkgs; [ rsync ];

  # limit size of system journal
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  services.postgresqlBackup = {
    enable = true;
    databases = [ "synapse" "mastodon" ];
  };

  system.stateVersion = "23.05";

}
