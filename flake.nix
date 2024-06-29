{

  description = "nixos config for multiple computers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    jovian.url = "github:Jovian-Experiments/Jovian-Nixos";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, hardware, nix-colors, jovian
    , firefox-addons, ... }: {
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
              home-manager.extraSpecialArgs = {
                inherit nix-colors firefox-addons;
              };
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

        backup = nixpkgs.lib.nixosSystem {
          system = "x86-64_linux";
          specialArgs = { inherit hardware; };
          modules = [
            ./nixos/backup.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.james = import ./home-manager/backup.nix;
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
