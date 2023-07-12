{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    vlc
    jellyfin-media-player
    sublime-music
    godot
    blender
    obs-studio
    gimp
    krita
    evolution
    signal-desktop
  ];
}
