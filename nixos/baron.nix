{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-cpu-amd

    ./hardware/baron.nix

    ./base
    ./gaming
    ./nfs-client
    ./pipewire
    ./virt

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # networking
  networking.hostName = "baron";

  # enable compression on btrfs root
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };



  programs.dconf.enable = true;

}

