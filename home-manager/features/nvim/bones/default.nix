{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # lua
      stylua
      # python
      black
      #nix
      nixfmt-classic
    ];
  };
}
