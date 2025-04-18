{ inputs, ... }:

{
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];

  programs.nix-index-database.comma.enable = true;

  nix = {
    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];

    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
