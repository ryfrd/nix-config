{ pkgs, ... }: {

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily      root     sh /etc/cron-jobs/docker-data-backup.sh"
      "@daily      root     sh /etc/cron-jobs/smart.sh"
    ];
  };

  # link scripts to etc
  environment.etc = {
    "cron-jobs/smart.sh" = {
      source = "./jobs/smart.sh";
    };
    "cron-jobs/docker-data-backup.sh" = {
      source = "./jobs/docker-data-backup.sh";
    };
  };

  # dependencies of job scripts
  environment.systemPackages = with pkgs; [
    gotify-cli
    smartmontools
  ];
}
