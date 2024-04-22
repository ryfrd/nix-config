{ lib, config, pkgs, nix-colors, ... }: {

  home.packages = with pkgs; [

    eza
    ripgrep
    fd
    curl
    wget
    unzip
    gnutar
    gzip
    tree
    dua
    htop
    pfetch
    dig
    fortune

    fishPlugins.z
    fishPlugins.autopair
    fishPlugins.done
    fishPlugins.sponge

    nodePackages.npm

  ];

  programs.home-manager.enable = true;
  home = {
    username = "james";
    homeDirectory = "/home/james";
  };
  home.stateVersion = "22.11";

  programs.starship = {
    enable = true;
    settings = { add_newline = true; };
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "eza";
      "grep" = "rg";
      "i" = "curl -s https://ipinfo.io";
      "c" = "clear && cd";
      "nxsh" = "nix-shell --command fish";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
    };
    functions = {
      twitch =
        "${pkgs.streamlink}/bin/streamlink https://twitch.tv/$argv[1] best -p mpv";
      port = "sudo netstat -tulpn | grep $argv[1]";
      cdir = "mkdir $argv[1] && cd $argv[1]";
      ssht = "ssh $argv -t 'tmux new -A'";
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

  programs.ranger = { enable = true; };

  programs.tmux = {
    enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    extraConfig = ''

      unbind C-b
      set -g prefix C-x

      bind-key Enter new-window

      bind-key - split-window -v
      bind-key | split-window -h

      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D

      bind-key h resize-pane -L 10
      bind-key l resize-pane -R 10
      bind-key k resize-pane -U 10
      bind-key j resize-pane -D 10

      set -g status-style bg=black
      set -g window-status-current-style bg=cyan,fg=black

    '';
  };

}
