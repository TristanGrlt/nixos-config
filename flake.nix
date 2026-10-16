{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nur,
      home-manager,
      disko,
      nixvim,
      sops-nix,
      ...
    }:
    let
      mylib = import ./lib { inherit (nixpkgs) lib; };

      mkSystem =
        {
          hostname,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              hostname
              mylib
              ;
          };
          modules = [
            ./hosts/${hostname}/configuration.nix

            disko.nixosModules.disko
            sops-nix.nixosModules.sops

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs mylib; };
              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
                sops-nix.homeManagerModules.sops
              ];
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        lap-greycanyon = mkSystem {
          hostname = "lap-greycanyon";
          username = "tristan";
        };
        lap-grassfields = mkSystem {
          hostname = "lap-grassfields";
          system = "x86_64-linux";
        };
      };
    };
}
