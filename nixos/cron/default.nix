{ pkgs, ... }: {

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@weekly      root     sh /etc/cron-jobs/smart.sh"
      "@monthly      root     sh /etc/cron-jobs/btrfs-maintenance.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/smart.sh" = {
      source = ./jobs/smart.sh;
    };
    "cron-jobs/btrfs-maintenance.sh" = {
      source = ./jobs/btrfs-maintenance.sh;
    };
  };

  # dependencies of job scripts
  environment.systemPackages = with pkgs; [
    gotify-cli
    smartmontools
  ];
}
