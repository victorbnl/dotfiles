{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    firefox-onebar = {
      url = "git+https://git.gay/freeplay/Firefox-Onebar";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  }@inputs: {
    nixosConfigurations = {
      Victor-PC = nixpkgs.lib.nixosSystem {
        modules = [
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              nur.overlays.default
            ];
          })

          home-manager.nixosModules.home-manager
          inputs.nix-index-database.nixosModules.nix-index

          ./nixos

          ({ pkgs, ... }: {
            programs.nix-index-database.comma.enable = true;

            home-manager = {
              useGlobalPkgs = true;
              backupFileExtension = "backup";

              users.victor = import ./home;

              extraSpecialArgs = {
                localpkgs = import ./packages { inherit pkgs; };
                inherit inputs;
              };
            };
          })
        ];
      };
    };
  };
}
