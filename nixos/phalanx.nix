{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    ./hardware/phalanx.nix

    ./base

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "phalanx";

  services.caddy = {
    enable = true;
    email="jdysmcl@tutanota.com";
    virtualHosts = {
      "read.jdysmcl.xyz" = {
        extraConfig = ''
          encode gzip
          root /var/www/blog
        '';
      };
    };
  };

}

