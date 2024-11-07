{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf
  ];

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvAdaptaDark
    '';

    "qt5ct/settings.ini".text = ''
      [Fonts]
      fixed="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
      general="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
    '';

    "qt6ct/settings.ini".text = ''
      [Fonts]
      fixed="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      general="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
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
      "Ubuntu"
    ];
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    gtk.enable = true;
  };
}
