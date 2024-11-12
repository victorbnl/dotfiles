{ pkgs, nur-repository, firefox-onebar, nix-vscode-extensions, ... }:
let
  nur = import nur-repository {
    nurpkgs = pkgs;
    pkgs = pkgs;
  };

  homeDir = "/home/victor";
in
{
  imports = [
    (import ./programs/firefox.nix { inherit nur firefox-onebar; })
    (import ./programs/vscode.nix { inherit pkgs nix-vscode-extensions; })

    ./programs/alacritty.nix
    ./appearance.nix
    ./dunst.nix
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
