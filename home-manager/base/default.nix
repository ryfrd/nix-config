{ outputs, pkgs, ... }: {

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

  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting ''
    ";
    shellAliases = {
      ls = "exa";
      grep = "rg";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      gush = "git add * && git commit -m '.' && git push";
      i = "curl -s ipinfo.io";
    };
    functions = {
      ss = "sudo systemctl $argv[1] $argv[2]";
      twitch = "streamlink https://twitch.tv/$argv[1] best -p mpv";
    };
  };
  home.packages = with pkgs.fishPlugins; [
    z
    autopair
    done
    sponge
    pure
  ];

  #programs.starship.enable = true;

  programs.git = {
    enable = true;
    userName = "ryfrd";
    userEmail = "jdysmcl@tutanota.com";
  };

  home.file.".ssh/config" = {
    # this uses tailscale 'magic dns' for hostname
    text = ''
      Host keep
        User james
        HostName keep
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host countess
        User james
        HostName countess
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host baron
        User james
        HostName baron
        Port 97
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";

}
