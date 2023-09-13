{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    ./hardware/phalanx.nix

    ./base
    ./docker

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "phalanx";

  networking.firewall.allowedTCPPorts = [ 80 443 5222 5269 5000 ];
  networking.firewall.allowedUDPPorts = [ 3478 3479 5349 5350 ];

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    ignoreIP = [ "countess" "baron" ]; # whitelist tailscale hosts
  };

  services.endlessh = {
    enable = true;
    openFirewall = true;
    port = 22;
  };

}
