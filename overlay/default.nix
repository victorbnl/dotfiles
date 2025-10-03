final: prev:
let
  call = name: final.callPackage (./pkgs + "/${name}.nix") {};
in
prev.lib.genAttrs [
  "power-menu"
  "vscode-menu"
  "vpn-helper"
  "vscode-recent"
] call
