{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.lenovo-thinkpad-t440p

    ./hardware/countess.nix

    ./base
    ./gnome
    ./nfs/client

  ];

  # bits and bobs not contained in base

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #hostName
  networking.hostName = "countess";

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable btrfs compression
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

}
