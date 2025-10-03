final: prev:
let
  inherit (final) callPackage;
in
builtins.mapAttrs (_: v: callPackage v {}) {
  power-menu = ./power-menu.nix;
  vscode-menu = ./vscode-menu.nix;
  vpn-helper = ./vpn-helper.nix;
  vscode-recent = ./vscode-recent.nix;
}
