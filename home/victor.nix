{ pkgs, ... }:

{
  imports = [ ./common ];

  home = {
    username = "victor";
    homeDirectory = "/home/victor";

    packages = with pkgs; [
      android-tools
      lutris
      mpv
      prismlauncher
      protonup-qt
      qbittorrent
      steam
      tor-browser
      yt-dlp
    ];
  };
}
