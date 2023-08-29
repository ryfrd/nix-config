{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscodium
    firefox
    mpv
    jellyfin-media-player
    sublime-music
    pulsemixer
    playerctl
    pamixer
    cava
  ];
}
