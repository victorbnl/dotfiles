{ pkgs, names, ... }:

{
  imports = [ ./common ];

  home = {
    username = names.user;
    homeDirectory = "/home/${names.user}";

    packages = with pkgs; [
      aseprite
      android-tools
      discord
      lutris
      mpv
      prismlauncher
      protonup-qt
      qbittorrent
      steam
      tor-browser
      vlc
      yt-dlp
    ];
  };
}
