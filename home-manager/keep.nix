{ pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./base

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

  # lowkey neovim setup for headless
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set noswapfile
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set number relativenumber
      set termguicolors
    '';
  };

  # tmux 4 headless fun
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set -g status-left ""
      set -g status-right " %H:%M:%S | %d/%m/%y "
    '';
  };

}
