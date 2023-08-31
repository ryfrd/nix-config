{
  fileSystems."/mnt/warhead" = {
    # keep tailscale ip
    device = "keep:/warhead";
    #device = "100.90.13.23:/warhead";
    fsType = "nfs";
    # lazy mount and auto disconnect
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };
}
