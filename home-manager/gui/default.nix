{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    mpv
    jellyfin-media-player
    sublime-music
  ];
}
