{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "vscode"
    "vscode-extension-ms-vscode-cpptools"
  ];

  home.packages = with pkgs; [
    android-tools
    blueman
    aria2
    devenv
    ferdium
    file
    gcc
    gimp
    gnumake
    gparted
    htop
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
    simple-scan
    sqlitebrowser
    tor-browser
    unzip
    viewnior
    yt-dlp
  ];
}
