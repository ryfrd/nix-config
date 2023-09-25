{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.lenovo-thinkpad-t14

    ./hardware/countess.nix

    ./base
    ./gaming
    ./nfs-client
    ./pipewire
    ./power
    ./virt

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "countess";

  # enable compression on btrfs root
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  # wifi
  networking.networkmanager.enable = true;
  # share dev items with tailnet
  networking.firewall.allowedTCPPorts = [ 1313 ];

  # backlight control
  programs.light.enable = true;
  users.users.james.extraGroups = [ "video" ];

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

}
