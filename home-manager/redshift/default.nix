{ pkgs, ... }: {
  services.redshift = {
    enable = true;
    latitude = 55.9;
    longitude = 4.3;
  };
}

