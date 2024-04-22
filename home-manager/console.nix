{ pkgs, ... }:{
  imports = [
    ./common
    ./features/nvim/headless
  ];

  home.packages = with pkgs; [ jellyfin-media-player firefox ];

}
