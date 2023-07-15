{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd

    ./hardware/keep.nix

    ./base
    ./cron
    ./docker
    ./reverse-proxy
    ./tlp/server

  ];
  environment.systemPackages = with pkgs; [ git home-manager neovim ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking.hostName = "keep";
  networking.firewall = {
    # syncthing ports
    allowedTCPPorts = [ 22000 21027 ];
    allowedUDPPorts = [ 22000 ];
  };

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/mnt/warhead".options = [ "compress=zstd" ];
  };

}
