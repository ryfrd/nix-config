{ pkgs, ... }: {
  programs.beets = {
    enable = true;
    settings = {
      directory = "/mnt/warhead/music";
      import = {
        copy = true;
        write = true;
      };
      plugins = "fetchart";
      fetchart.auto = true;
    };
  };

  home.packages = with pkgs; [
    shntool
    cuetools
    flac
  ];
}
