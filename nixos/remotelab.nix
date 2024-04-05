{ pkgs, ... }: {

  imports = [

    ./hardware/remotelab.nix

    ./common
    ./features/docker
    ./features/ssh/highkey

  ];

  networking.hostName = "remotelab";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    rsync
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily	root	sh /etc/cronjobs/backup.sh /home/james/phalanx-docker"
    ];
  };

  environment.etc = {
    "cronjobs/backup.sh" = {
      source = ./cronjobs/backup.sh;
    };
  };

}
