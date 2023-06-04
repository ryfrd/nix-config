{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = ''
    vim.cmd('set noswapfile')
    vim.cmd('set tabstop=4')
    vim.cmd('set softtabstop=4')
    vim.cmd('set shiftwidth=4')
    vim.cmd('set expandtab')
    vim.cmd('set number relativenumber')
    vim.cmd('set termguicolors')
    '';
  };
}
