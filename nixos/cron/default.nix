{ pkgs, ...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      # copy docker data from root drive to mount daily
      "@daily      root     sh /home/james/nix-config/nixos/cron/jobs/docker-data-backup.sh"
      "@daily      root     sh /home/james/nix-config/nixos/cron/jobs/smart.sh"
    ];
  };
  environment.systemPackages = with pkgs; [ 
    gotify-cli
    smartmontools
  ];
}
