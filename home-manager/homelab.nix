{ pkgs, nix-colors, ... }: {
  imports = [
    ./common
  ];

  home.packages = with pkgs; [
    flac
    shntool
    cuetools
  ];

}
