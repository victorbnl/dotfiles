{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nur-repository.url = "github:nix-community/NUR";

    firefox-onebar = {
      url = "https://git.gay/freeplay/Firefox-Onebar/raw/branch/waf/onebar.css";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }@inputs: {
    nixosConfigurations = {
      Victor-PC = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          inputs.nix-index-database.nixosModules.nix-index

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
