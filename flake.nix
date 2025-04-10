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
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ nur.overlays.default ];
    };

    localpkgs = import ./packages { inherit pkgs; };

    secrets = (import ./secrets.nix);
  in
  {
    nixosConfigurations = {
      "installer" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./installer ];
      };

      "Victor-ThinkPad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs secrets; };
        modules = [ ./nixos/thinkpad.nix ];
      };
    };

    homeConfigurations = {
      "victor@Victor-ThinkPad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs localpkgs; };
        modules = [ ./home/victor.nix ];
      };
    };
  };
}
