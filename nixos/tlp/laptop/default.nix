{ pkgs, ... }: {
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE=1;
    };
  };
}
