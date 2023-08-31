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

if shared between all machines plop in base
if used by more than one machine but not all create separate import
if used by one machine plop in machine specific file eg. keep.nix
pog
pog
