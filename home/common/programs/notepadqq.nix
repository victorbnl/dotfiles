{ pkgs, ... }:

{
  home.packages = [ pkgs.notepadqq ];

  xdg.configFile."Notepadqq/Notepadqq.ini".text = ''
    [Appearance]
    ColorScheme=base16-dark
    OverrideFontSize=20
  '';
}
