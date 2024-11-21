{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    blueman
    ferdium
    gimp
    gparted
    libreoffice-fresh
    lutris
    networkmanagerapplet
    pavucontrol
    pcmanfm
    protonup-qt
    python3
    qbittorrent
    sqlitebrowser
    yt-dlp
  ];
}
