{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "aseprite"
    "discord"
    "steam"
    "steam-unwrapped"
    "vscode"
  ];

  home.packages = with pkgs; [
    # dev
    devenv gnumake python3 sqlitebrowser ungit

    # utils
    file htop krename nmap pavucontrol qbittorrent simple-scan unzip
    virt-manager xarchiver zip

    # art / media
    aseprite gimp mpv viewnior vlc yt-dlp

    # gaming
    lutris prismlauncher protonup-qt steam

    # other
    android-tools tor-browser
  ];
}
