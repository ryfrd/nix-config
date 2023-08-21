{ inputs, outputs, lib, config, pkgs, ... }: {

  # nix
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
      # allows remote rebuild
      trusted-users = [ "james" ];
    };
  };

  # networking
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  services.tailscale.enable = true;

  # ssh
  services.openssh = {
    enable = true;
    ports = [ 97 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 97 ];

  # time zone
  time.timeZone = "Europe/London";

  # locale
  i18n.defaultLocale = "en_GB.UTF-8";

  # user
  users.users = {
    james = {
      isNormalUser = true;
      shell = pkgs.fish;
      initialPassword = "changethisyoupickle";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKW4ofxuyFKtDXCHHR6UDf5hGolKwZqt3h7SFLCCy++6 james@baron"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5Sr7q3RAuO6QIpu9tCLXF5cTs6mq7TRbDfVsglCDei james@countess"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWqX/8jJfWVfMmFDbOao0w1OVszEm/H6Us/klsDgYxp james@keep"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBxHtFYZctBvOOW/VdN/ETCGE3vK3ZvIjNku1b5wgKj james@bastion"
      ];
    };
  };
  programs.fish.enable = true;

  # graphics
  hardware.opengl.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";

}

