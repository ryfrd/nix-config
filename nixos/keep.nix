{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd

    ./hardware/keep.nix

    ./cron
    ./docker
    ./reverse-proxy
    ./ssh/lowkey
    ./tailscale
    ./tlp/server

  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

    ];
    config = {
      allowUnfree = false;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # networking
  networking = {
    hostName = "keep";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 21027 ];
      allowedUDPPorts = [ 22000 ];
    };
  };
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # disable ipv6
  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # time zone
  time.timeZone = "Europe/London";

  # locale
  i18n.defaultLocale = "en_GB.UTF-8";

  # user
  users.users = {
    james = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      initialPassword = "changethisyoupickle";
    };
  };
  programs.fish.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
