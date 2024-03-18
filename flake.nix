{

  description = "nixos config for multiple compouters";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{
    nixpkgs,
    home-manager,
    nix-colors,
    hardware,
    ...
  }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86-64_linux";
    	specialArgs = { inherit hardware; };
        modules = [
          ./nixos/laptop.nix
	      home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.james = import ./home-manager/laptop.nix;
	        home-manager.extraSpecialArgs = { inherit nix-colors; };
	      }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/desktop.nix
        ];
      };
      homelab = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/homelab.nix
        ];
      };
      remotelab = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/remotelab.nix
        ];
      };
    };
  };
}
