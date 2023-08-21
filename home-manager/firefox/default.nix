{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.james = {
      extensions = with pkgs.firefox-addons; [
        ublock-origin
        darkreader
      ];
    };
  };
}
