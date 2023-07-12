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
      hm = "home-manager switch --flake .#$(echo $USER@$hostname)";
      nr = "sudo nixos-rebuild switch --flake .#$(echo $hostname)";
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";

}
