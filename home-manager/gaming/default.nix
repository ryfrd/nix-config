{ pkgs, ... }: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      font_size = 16;
      full = true;
    };
  };
}
