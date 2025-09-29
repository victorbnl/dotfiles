final: prev:
let
  inherit (final) callPackage;
in
{
  rofi-power-menu = callPackage ./rofi-power-menu.nix {};
  rofi-vscode-recent = callPackage ./rofi-vscode-recent.nix {};
  vscode-recent = callPackage ./vscode-recent.nix {};
}
