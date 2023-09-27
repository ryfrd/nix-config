{ pkgs, lib, ... }: {
  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
    "steam-run"
  ];

  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx # genesis
        mgba # gameboy advance
        snes9x # snes
        citra # 3ds
        desmume # ds 
        dolphin # gamecube & wii
        mupen64plus # 64
        beetle-psx-hw # psx
        ppsspp # psp
        pcsx2 # ps2
      ];
    })
  ];

}

