{ pkgs, ...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      # copy docker data from root drive to mount daily
      "@daily      root    cp -r /srv /mnt/warhead/backup/docker"
    ];
  };
}
