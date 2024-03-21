{ lib, config, pkgs, nix-colors, ... }: {

  home.packages = with pkgs; [

    eza
    ripgrep
    fd
    curl
    wget
    tree
    dua
    htop
    pfetch
    dig

    fishPlugins.z
    fishPlugins.autopair
    fishPlugins.done
    fishPlugins.sponge

  ];

  programs.home-manager.enable = true;
  home = {
    username = "james";
    homeDirectory = "/home/james";
  };
  home.stateVersion = "22.11";

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };
  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting ''
      pfetch
      starship init fish | source
    ";
    shellAliases = {
      "ls" = "eza";
      "grep" = "rg";
      "i" = "curl -s https://ipinfo.io";
      "update" = "cd ~/sync/nix/multihost && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)";
      "c" = "clear && cd";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
    };
    functions = {
      twitch = "${pkgs.streamlink}/bin/streamlink https://twitch.tv/$argv[1] best -p mpv";
      port = "sudo netstat -tulpn | grep $argv[1]";
      cdir = "mkdir $argv[1] && cd $argv[1]";
    };
  };
  home.sessionVariables = {
    PF_INFO = "os kernel uptime memory shell editor palette";
  };

  programs.git = {
    enable = true;
    userName = "ryfrd";
    userEmail = "jdysmcl@tutanota.com";
  };

  programs.ranger = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    newSession = false;
  };

}
