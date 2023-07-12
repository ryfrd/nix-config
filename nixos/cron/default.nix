{ pkgs, ... }: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily      root     sh /home/james/nix-config/nixos/cron/jobs/docker-data-backup.sh"
      "@daily      root     sh /home/james/nix-config/nixos/cron/jobs/smart.sh"
    ];
  };

  # dependencies of job scripts
  environment.systemPackages = with pkgs; [
    gotify-cli
    smartmontools
  ];
}
