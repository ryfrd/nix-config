{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    package = pkgs.steam-small.override {
      extraEnv = {
        MANGOHUD = true;
      };
    };
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        citra
        desmume
        dolphin
        ppsspp
      ];
    })
  ];
}
