{ pkgs, nix-colors, ... }: {
  imports = [ ./common ./features/nvim/bones ];

  home.packages = with pkgs; [ flac shntool cuetools ];

}
