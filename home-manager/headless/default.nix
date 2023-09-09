{ pkgs, ... }: {
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
