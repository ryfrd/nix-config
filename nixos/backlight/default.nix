{ pkgs, ... }: {
  programs.light.enable = true;
  users.users.james.extraGroups = [ "video" ];
}
