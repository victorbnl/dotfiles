{ pkgs, inputs, modulesPath, names, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  users.motd = "Run `i` to install the system.";

  environment.shellAliases.i = "sudo " + (import ./script.nix {
    inherit pkgs names;
    inherit (inputs) disko;
    flake = ../.;
  });

  zramSwap.enable = true;
  console.keyMap = "fr";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  isoImage.squashfsCompression = "lz4";
}
