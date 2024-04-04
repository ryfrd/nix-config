{ pkgs, nix-colors, ... }: {
  imports = [
    ./common
    ./features/nvim/headless
  ];

  home.packages = with pkgs; [
    flac
    shntool
    cuetools
  ];

}
