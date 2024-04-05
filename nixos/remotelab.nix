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

  networking.firewall.allowedTCPPorts = [
    80 443 # http/s
    # snikket
    5222 # federation
    5000 # file transfer proxy
  ];

  time.timeZone = "Europe/Berlin";

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

  # cronjob deps
  # required system wide as jobs run as root
  environment.systemPackages = with pkgs; [
    rsync
  ];


}
