{

  description = "nixos config for multiple computers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    jovian.url = "github:Jovian-Experiments/Jovian-Nixos";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, hardware, nix-colors, jovian, ... }: {
      nixosConfigurations = {

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86-64_linux";
          specialArgs = { inherit hardware; };
          modules = [
            ./nixos/laptop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/laptop.nix;
              home-manager.extraSpecialArgs = { inherit nix-colors; };
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86-64_linux";
          specialArgs = { inherit hardware; };
          modules = [
            ./nixos/desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/desktop.nix;
              home-manager.extraSpecialArgs = { inherit nix-colors; };
            }
          ];
        };

        console = nixpkgs.lib.nixosSystem {
          system = "x86-64_linux";
          specialArgs = { inherit hardware jovian; };
          modules = [
            ./nixos/console.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/console.nix;
            }
          ];
        };

        homelab = nixpkgs.lib.nixosSystem {
          system = "x86-64_linux";
          specialArgs = { inherit hardware; };
          modules = [
            ./nixos/homelab.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/homelab.nix;
            }
          ];
        };

        remotelab = nixpkgs.lib.nixosSystem {
          system = "aarch64_linux";
          specialArgs = { inherit hardware; };
          modules = [
            ./nixos/remotelab.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/remotelab.nix;
            }
          ];
        };

      };
    };
}
