{ pkgs, ... }: {

  imports = [ ./common ./features/nvim/bones ];

  home.packages = [
    (pkgs.kodi-wayland.passthru.withPackages
      (kodiPkgs: with kodiPkgs; [ jellyfin ]))
  ];

}
