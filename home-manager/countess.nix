{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    ./fish
    ./git
    ./gtk/de
    ./kitty
    ./nvim/lazy
    ./syncthing

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

  colorscheme = inputs.nix-colors.colorschemes.gruvbox-dark-soft;

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # gui
    firefox
    vlc
    signal-desktop
    jellyfin-media-player
    sublime-music
    evolution

    # cli
    fortune
    cava
    wl-clipboard
    streamlink
    pulsemixer
    ranger
    tree
    htop
    curl
    exa
    ripgrep
    dua

    #custom
    fetch
    journal

  ];

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
