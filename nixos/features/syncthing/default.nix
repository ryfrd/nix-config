{ pkgs, ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/james";
    user = "james";
    group = "users";
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
    settings.devices = {
      keep = {
        id = "E7CSWUI-DU54WT6-RESZSHE-TA36Z7Q-4ACTOQR-KU2KA22-DII6YIL-YOXPGAM";
      };
    };
  };
}
