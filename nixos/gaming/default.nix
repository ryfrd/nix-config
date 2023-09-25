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
    (lutris.override {
      extraPkgs =  pkgs: [
        fuse
        p7zip
        #libretro.desmume #ds
        #libretro.mupen64plus #n64
        #libretro.ppsspp #psp
        #libretro.snes9x #snes
      ];
    })
    mindustry
    wesnoth
  ];

}

