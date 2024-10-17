{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings.exec-once =
    [ "hyprctl setcursor Bibata-Modern-Classic 24" ];
  home.packages = with pkgs; [ bibata-cursors ];
}
