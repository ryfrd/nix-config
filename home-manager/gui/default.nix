{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    vlc
    jellyfin-media-player
    sublime-music
    lapce
  ];
}
