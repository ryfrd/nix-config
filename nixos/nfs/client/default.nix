{ pkgs, ... }: {
  fileSystems."/mnt/warhead" = {
    device = "100.75.28.123:/warhead";
    fsType = "nfs";
  };
}
