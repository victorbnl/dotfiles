{ localpkgs, ... }:

{
  xdg.configFile."Ferdium/config/custom.css".source =
    "${localpkgs.ferdium-theme}/theme.css";
}
