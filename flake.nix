{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nix-index-database, ... }: {
    nixosConfigurations = {
      Victor-PC = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix

          nix-index-database.nixosModules.nix-index
          {
            programs.nix-index-database.comma.enable = true;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.victor = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}