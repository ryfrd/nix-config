{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.lenovo-thinkpad-t14

    ./hardware/countess.nix

    ./backlight
    ./base
    ./bluetooth
    ./nfs/client
    ./pipewire
    ./power
    ./steam
    ./virt

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
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
