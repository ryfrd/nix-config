{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    wget
    dua
    ranger

    #custom
    fetch
  ];
}
