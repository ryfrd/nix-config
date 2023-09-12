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

  #security.acme = {
  #  acceptTerms = true;
  #  defaults.email = "jdysmcl@tutanota.com";
  #};
  #services.nginx = {
  #  enable = true;
  #  virtualHosts."read.jdysmcl.xyz" = {
  #    enableACME = true;
  #    forceSSL = true;
  #    root = "/var/www/blog/";
  #  };
  #};
  #networking.firewall.allowedTCPPorts = [ 80 443 ];

}

