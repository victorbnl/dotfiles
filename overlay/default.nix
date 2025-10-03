final: prev:
let
  inherit (final) callPackage;
in
builtins.mapAttrs (_: v: callPackage v {}) {
  rofi-power-menu = ./rofi-power-menu.nix;
  rofi-vscode-recent = ./rofi-vscode-recent.nix;
  vpn-helper = ./vpn-helper.nix;
  vscode-recent = ./vscode-recent.nix;
}
