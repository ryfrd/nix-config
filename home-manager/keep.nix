{ pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./base
    ./headless

  ];

  # beets and tools for flac fiddling
  programs.beets = {
    enable = true;
    settings = {
      directory = "/mnt/warhead/media/music";
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
