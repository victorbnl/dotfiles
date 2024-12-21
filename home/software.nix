{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    blueman
    devenv
    ferdium
    gimp
    gparted
    libreoffice-fresh
    lutris
    mpv
    networkmanagerapplet
    nmap
    pavucontrol
    pcmanfm
    prismlauncher
    protonup-qt
    python3
    qbittorrent
    sqlitebrowser
    tor-browser
    viewnior
    yt-dlp
  ];
}
