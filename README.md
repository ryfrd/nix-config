nix config for my computers!!!

### update flake inputs

`nix flake update`

### rebuild system

`sudo nixos-rebuild switch --flake github:ryfrd/nix-config`

### rebuild home

`home-manager switch --flake github:ryfrd/nix-config`

### machines

- countess (laptop)
- baron (desktop gaming powerhouse)
- keep (home server)
- bastion (dns + homeassistant + backup box)

