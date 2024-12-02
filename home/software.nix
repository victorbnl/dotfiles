{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    blueman
    ferdium
    gimp
    gparted
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
