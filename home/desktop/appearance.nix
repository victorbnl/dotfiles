{ pkgs, ... }:
let
  font = "Noto Sans";
  qtFont = "${font},10";
in
{
  programs.kvantum = {
    enable = true;
    theme = "KvAdaptaDark";
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = ''
      [Fonts]
      fixed="${qtFont},-1,5,50,0,0,0,0,0,Regular"
      general="${qtFont},-1,5,50,0,0,0,0,0,Regular"
    '';

    "qt6ct/qt6ct.conf".text = ''
      [Fonts]
      fixed="${qtFont},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      general="${qtFont},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    '';
  };

  gtk = {
    enable = true;

    theme = {
      name = "Vimix-dark-doder";
      package = pkgs.vimix-gtk-themes;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  fonts.fontconfig = {
    enable = true;

    defaultFonts.sansSerif = [
      font
    ];
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    gtk.enable = true;
  };
}
