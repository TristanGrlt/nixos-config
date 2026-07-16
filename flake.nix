{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }: {
      nixosConfigurations = {
	# nixos = hostname
        lap-greycanyon = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/lap-greycanyon/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.tristan = ./users/tristan/home.nix;
            }
          ];
        };
      };
    };
}
