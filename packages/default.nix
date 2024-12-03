{ pkgs }:

{
  ferdium-theme = pkgs.callPackage ./ferdium-theme/default.nix {};
  rofi-power-menu = pkgs.callPackage ./rofi-power-menu/default.nix {};
}
