{ pkgs, ... }:
let
  font = "Ubuntu";
  qtFont = "${font},10";
in
{
  home.packages = with pkgs; [
    dconf
  ];

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvAdaptaDark
    '';

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
      name = "vimix-dark-doder";
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
