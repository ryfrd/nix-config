{ pkgs, ... }: {
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.james.enableGnomeKeyring = true;
  security.polkit.enable = true;
}
