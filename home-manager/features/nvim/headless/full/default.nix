{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      mini-nvim
      bufferline-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      vim-illuminate
      indent-blankline-nvim
      nvim-web-devicons
      plenary-nvim
    ];
  };

  home.file.".config/nvim/init.lua" = {
    enable = true;
    recursive = false;
    source = ./init.lua;
  };

}
