{ pkgs, ... }: {

  fileSystems."/export/warhead" = {
    device = "/mnt/warhead";
    options = [ "bind" ];
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /export   countess(rw,fsid=0,no_subtree_check)    baron(rw,fsid=0,no_subtree_check)
      /export/warhead   countess(rw,nohide,insecure,no_subtree_check)   baron(rw,nohide,insecure,no_subtree_check)
    '';
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];

}
