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
        { hostname, username }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hostname
              username
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
              home-manager.extraSpecialArgs = { inherit inputs username mylib; };
              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
                sops-nix.homeManagerModules.sops
              ];
              home-manager.backupFileExtension = "backup";

              home-manager.users.${username} = import ./users/${username}/default.nix;
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
          username = "tristan";
        };
      };
    };
}
