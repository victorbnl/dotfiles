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
    nmap
    pavucontrol
    pcmanfm
    prismlauncher
    protonup-qt
    python3
    qbittorrent
    sqlitebrowser
    viewnior
    yt-dlp
  ];
}
