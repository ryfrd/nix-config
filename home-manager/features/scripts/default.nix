{ pkgs, ... }: {
  home.file.".config/scripts" = {
    enable = true;
    recursive = true;
    source = ./meat;
  };
  # script deps
  home.packages = with pkgs; [
    pamixer
  ];
}
