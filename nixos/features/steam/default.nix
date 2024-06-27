{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    package = pkgs.steam-small.override { extraEnv = { MANGOHUD = true; }; };
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  nixpkgs.config.allowUnfree = true; # for steam
}
