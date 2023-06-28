{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./beets
    ./fish
    ./nvim/headless

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = false;
    };
  };

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "robbygozzarder";
    userEmail = "jdysmcl@tutanota.com";
  };

  home.packages = with pkgs; [
    # cli
    ranger
    tree
    htop
    curl
    exa
    ripgrep

    #custom
    fetch

  ];

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
