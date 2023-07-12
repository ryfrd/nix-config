{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    tree
    ripgrep
    htop
    curl
    wget

    #custom
    fetch
  ];
}
