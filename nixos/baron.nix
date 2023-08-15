{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware/baron.nix

    ./base
    ./bluetooth
    ./de/qtile
    ./nfs/client
    ./pipewire
    ./steam

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # networking
  networking.hostName = "baron";

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
