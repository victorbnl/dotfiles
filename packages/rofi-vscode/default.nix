{ stdenv, pkgs }:
let
  vscode-recent = (pkgs.callPackage ./vscode-recent.nix {});
in
stdenv.mkDerivation {
  pname = "rofi-vscode";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp script.sh $out/bin/rofi-vscode
    makeWrapper $src/script.sh $out/bin/rofi-vscode \
      --set VSCODE_RECENT "${vscode-recent}/bin/vscode-recent"
  '';
}
