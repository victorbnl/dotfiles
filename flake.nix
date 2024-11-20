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
      url = "https://git.gay/freeplay/Firefox-Onebar/raw/branch/waf/onebar.css";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
              nur.overlay
            ];
          })

          home-manager.nixosModules.home-manager
          inputs.nix-index-database.nixosModules.nix-index

          ./nixos/configuration.nix

          {
            programs.nix-index-database.comma.enable = true;

            home-manager = {
              useGlobalPkgs = true;
              backupFileExtension = "backup";

              users.victor = import ./home-manager/home.nix;

              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}
