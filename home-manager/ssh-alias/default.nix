{ pkgs, ... }: {
  home.file.".ssh/config" = {
    # this uses tailscale ip
    text = ''
      Host keep
        User james
        HostName 100.75.28.123
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host countess
        User james
        HostName 100.89.246.41
        Port 97
        IdentityFile ~/.ssh/id_ed25519

      Host baron
        User james
        HostName 100.100.176.11
        Port 97
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
