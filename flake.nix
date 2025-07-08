{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    arsenik = {
      url = "https://github.com/OneDeadKey/arsenik/releases/download/0.2.0/arsenik-0.2.0.zip";
      flake = false;
    };

    boilerplates = {
      url = "git+https://github.com/victorbnl/boilerplates";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  }@inputs:
  let
    names = {
      user = "marie";
      host = "Marie-ThinkPad";
    };

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ nur.overlays.default ];
    };

    localpkgs = import ./packages { inherit pkgs; };

    secrets = import ./secrets.nix;

    root = ./.;
  in
  {
    nixosConfigurations = {
      "installer" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs names; };
        modules = [ ./installer ];
      };

      "${names.host}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs secrets names root; };
        modules = [ ./nixos/thinkpad.nix ];
      };
    };

    homeConfigurations = {
      "${names.user}@${names.host}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs localpkgs names root; };
        modules = [ ./home/user.nix ];
      };
    };
  };
}
