{ pkgs, ... }: {
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
