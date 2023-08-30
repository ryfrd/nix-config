{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.lenovo-thinkpad-t14

    ./hardware/countess.nix

    ./base
    ./nfs-client
    ./pipewire
    ./power
    ./steam
    ./virt

  ];

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "countess";

  # backlight control
  programs.light.enable = true;
  users.users.james.extraGroups = [ "video" ];

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


}
