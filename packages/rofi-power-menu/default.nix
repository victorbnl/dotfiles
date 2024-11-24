{ stdenv, pkgs }:

stdenv.mkDerivation {
  pname = "rofi-power-menu";
  version = "1.0.0";

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin $out/share/$pname
    cp config.rasi $out/share/$pname/power-menu-config.rasi
    makeWrapper $src/script.sh $out/bin/rofi-power-menu \
     --set CONFIG_FILE $out/share/$pname/power-menu-config.rasi
  '';
}
