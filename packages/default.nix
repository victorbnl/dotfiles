{ pkgs }:

{
  ferdium-theme = pkgs.callPackage ./ferdium-theme {};
  rofi-power-menu = pkgs.callPackage ./rofi-power-menu {};
}
