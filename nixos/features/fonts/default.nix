{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira
      (nerdfonts.override { fonts = [ "Agave" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Agave Nerd Font" ];
        sansSerif = [ "Fira Sans" ];
        serif = [ "Fira Serif" ];
      };
    };
  };
}
