{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  #environment.systemPackages = with pkgs; [ quickemu ];
  users.users.james.extraGroups = [ "libvritd" ];
}
