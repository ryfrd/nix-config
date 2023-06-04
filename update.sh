sudo nix-collect-garbage -d &&
nix flake update &&
sudo nixos-rebuild switch --flake .#$(echo $hostname) &&
home-manager switch --flake .#$(echo $USER@$hostname)
