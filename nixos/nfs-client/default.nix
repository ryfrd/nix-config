{
  fileSystems."/mnt/warhead" = {
    # uses tailscale 'magic dns' hostname
    device = "keep:/warhead";
    fsType = "nfs";
    # lazy mount and auto disconnect
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };
}
