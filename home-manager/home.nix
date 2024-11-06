{ pkgs, ... }:
let
  homeDir = "/home/victor";
in
{
  imports = [
    ./programs/alacritty.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./appearance.nix
    ./i3.nix
    ./polybar.nix
  ];

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;
  };

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";
  };

  xdg.userDirs = {
    enable = true;

    desktop = "${homeDir}/desktop";
    documents = "${homeDir}/documents";
    download = "${homeDir}/downloads";
    music = "${homeDir}/music";
    pictures = "${homeDir}/pictures";
    publicShare = "${homeDir}/public";
    templates = "${homeDir}/templates";
    videos = "${homeDir}/videos";
  };

  home.stateVersion = "24.05";
}
