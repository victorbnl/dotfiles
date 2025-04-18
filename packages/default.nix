{ pkgs }:

{
  ferdium-theme = pkgs.callPackage ./ferdium-theme {};
  rofi-vscode = pkgs.callPackage ./rofi-vscode {};
}
