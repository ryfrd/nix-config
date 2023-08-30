{ outputs, pkgs, ... }: {
  
  # user configuration i want on all systems

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

  programs.home-manager.enable = true;

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };

  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    # command line essentials
    exa
    ripgrep
    curl
    wget
    tree
    htop
    dua
    ranger
    fortune
    fetch

    # fish plugins
    fishPlugins.z
    fishPlugins.autopair
    fishPlugins.done
    fishPlugins.sponge

  ];

  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting ''
      starship init fish | source
    ";
    shellAliases = {
      ls = "exa";
      grep = "rg";
      i = "curl -s ipinfo.io";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      gush = "git add * && git commit -m '.' && git push";
      kssh = "kitty + kitten ssh";
    };
    functions = {
      ss = "sudo systemctl $argv[1] $argv[2]";
      twitch = "streamlink https://twitch.tv/$argv[1] best -p mpv";
    };
  };
  programs.starship.enable = true;

  programs.git = {
    enable = true;
    userName = "ryfrd";
    userEmail = "jdysmcl@tutanota.com";
  };

  home.file.".ssh/config" = {
    # this uses tailscale ip
    text = ''
      Host keep
        User james
        HostName 100.90.13.23
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host countess
        User james
        HostName 100.121.230.21
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host baron
        User james
        HostName 100.100.176.11
        Port 97
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";

}
