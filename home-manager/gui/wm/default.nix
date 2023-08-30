{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    mpv
    jellyfin-media-player
    pulsemixer
    playerctl
    pamixer
    cava
  ];
}
