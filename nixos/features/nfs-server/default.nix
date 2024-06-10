{
  networking.firewall.allowedTCPPorts = [
    2049 # nfs v4
  ];
  services.nfs.server = {
    enable = true;
    exports = ''
      # share folders with lan
      /warhead/high-prio/music  192.168.1.0/24(ro)
      /warhead/high-prio/sync  192.168.1.0/24(ro)
      /warhead/high-prio/games  192.168.1.0/24(ro)
      /warhead/low-prio/tv  192.168.1.0/24(ro)
      /warhead/low-prio/films  192.168.1.0/24(ro)
    '';
  };
}
