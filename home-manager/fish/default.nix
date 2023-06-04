{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellInit = "\nfetch\nstarship init fish | source";
    shellAliases = {
      ls="exa";
      grep="rg";
      ".."="cd ..";
      "..."="cd ../../";
      "...."="cd ../../../";
      gush = "git add * && git commit -m '.' && git push";
      i="curl -s ipinfo.io";
      hm="home-manager switch --flake .#$(echo $USER@$hostname)";
      nr="sudo nixos-rebuild switch --flake .#$(echo $hostname)";
      cg="sudo nix-collect-garbage -d";
    };
    functions = {
      ss = "sudo systemctl $argv[1] $argv[2]";
      twitch = "streamlink https://twitch.tv/$argv[1] best -p mpv";
    };
  };
  programs.starship.enable = true;
}
