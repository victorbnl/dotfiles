{ stdenv, pkgs }:

stdenv.mkDerivation {
  pname = "ferdium-theme";
  version = "1.0.0";

  nativeBuildInputs = [ pkgs.sass ];

  src = ./.;

  installPhase = ''
    mkdir -p $out
    sass theme.scss $out/theme.css
  '';
}
