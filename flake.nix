{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      # Force home-manger to use the same nixpkgs as the systeme
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      mylib = import ./lib { inherit (nixpkgs) lib; };
      mkSystem = { hostname, username }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs hostname username mylib; };

          modules = [
            ./hosts/${hostname}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs username mylib; };
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    in {
      nixosConfigurations = {
        lap-greycanyon = mkSystem {
          hostname = "lap-greycanyon";
          username = "tristan";
        };
      };
    };
}
