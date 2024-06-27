{
  home.file.".ssh/config".text = ''
    Host homelab
      HostName 100.64.0.3
      User james
      Port 97
      IdentityFile ~/.ssh/id_ed25519

    Host remotelab
      HostName 100.64.0.2
      User james
      Port 97
      IdentityFile ~/.ssh/id_ed25519

    Host console
      HostName 100.64.0.6
      User james
      Port 97
      IdentityFile ~/.ssh/id_ed25519

    Host router
      HostName 192.168.1.1
      User root
      Port 97
      IdentityFile ~/.ssh/id_ed25519
  '';
}
