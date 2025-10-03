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
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        nur.overlays.default
        (import ./overlay)
      ];
    };

    names = {
      user = "marie";
      host = "Marie-ThinkPad";
    };

    root = ./.;

    secrets = import ./secrets { inherit root; };

    specialArgs = { inherit inputs names root secrets; };
    extraSpecialArgs = specialArgs;
  in
  {
    nixosConfigurations = {
      "installer" = nixpkgs.lib.nixosSystem {
        inherit pkgs system specialArgs;
        modules = [ ./installer ];
      };

      "${names.host}" = nixpkgs.lib.nixosSystem {
        inherit pkgs system specialArgs;
        modules = [ ./nixos/thinkpad.nix ];
      };
    };

    homeConfigurations = {
      "${names.user}@${names.host}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [ ./modules/home.nix ./home ];
      };
    };
  };
}
