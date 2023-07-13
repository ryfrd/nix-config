{ pkgs, ... }: {
  services.openssh = {
    enable = true;
    ports = [ 97 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 97 ];
}
