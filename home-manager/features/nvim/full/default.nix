{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      mini-nvim
      zen-mode-nvim
      glow-nvim
      bufferline-nvim
      lualine-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      telescope-nvim
      telescope-file-browser-nvim
      which-key-nvim
      vim-illuminate
      indent-blankline-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-web-devicons
      plenary-nvim
      lazy-nvim
    ];
  };

  home.file.".config/nvim" = {
    enable = true;
    recursive = true;
    source = ./lua;
  };

  home.file.".config/nvim/colors.lua" = {
    enable = true;
    recursive = false;
    text = ''
    local function make_theme()
    require('mini.base16').setup({
      palette = {
        base00 = '#${config.colorScheme.palette.base00}',
        base01 = '#${config.colorScheme.palette.base01}',   
        base02 = '#${config.colorScheme.palette.base02}',    
        base03 = '#${config.colorScheme.palette.base03}',    
        base04 = '#${config.colorScheme.palette.base04}',    
        base05 = '#${config.colorScheme.palette.base05}',
        base06 = '#${config.colorScheme.palette.base06}',    
        base07 = '#${config.colorScheme.palette.base07}',    
        base08 = '#${config.colorScheme.palette.base08}',    
        base09 = '#${config.colorScheme.palette.base09}',   
        base0A = '#${config.colorScheme.palette.base0A}',    
        base0B = '#${config.colorScheme.palette.base0B}',    
        base0C = '#${config.colorScheme.palette.base0C}',   
        base0D = '#${config.colorScheme.palette.base0D}',
        base0E = '#${config.colorScheme.palette.base0E}',
        base0F = '#${config.colorScheme.palette.base0F}',    
      },
    })
    end
    return make_theme
    '';
  };

  home.packages = with pkgs; [
    gcc
    nodePackages.pyright
    nil
  ];

}
