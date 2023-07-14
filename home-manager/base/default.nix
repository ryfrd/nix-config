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
      fetch
      starship init fish | source
    ";
    shellAliases = {
      ls = "exa";
      grep = "rg";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      gush = "git add * && git commit -m '.' && git push";
      i = "curl -s ipinfo.io";
      hm = "home-manager switch --flake github:ryfrd/nix-config";
      nr = "sudo nixos-rebuild switch --flake github:ryfrd/nix-config";
      cg = "sudo nix-collect-garbage -d";
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
        HostName 100.74.212.132
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host countess
        User james
        HostName 100.89.246.41
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
