{ pkgs, ... }: {
  fileSystems."/export/warhead" = {
    device = "/mnt/warhead";
    options = [ "bind" ];
  };
  services.nfs.server = {
    enable = true;
    exports = ''
      /export         100.89.246.41(rw,fsid=0,no_subtree_check) 100.77.195.6(rw,fsid=0,no_subtree_check)
      /export/warhead         100.89.246.41(rw,fsid=0,no_subtree_check) 100.77.195.6(rw,fsid=0,no_subtree_check)
    '';
  };
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
