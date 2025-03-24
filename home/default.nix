{ config, ... }:

{
  imports = [
    ./desktop
    ./programs

    ./software.nix
  ];

  home = {
    username = "victor";
    homeDirectory = "/home/victor";
  };

  home.file.".xprofile".text = ''
    . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';

  xdg = {
    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/pdf" = [ "firefox.desktop" ];
        "application/zip" = [ "xarchiver.desktop" ];
        "image/jpeg" = [ "viewnior.desktop" ];
        "image/png" = [ "viewnior.desktop" ];
        "text/plain" = [ "notepadqq.desktop" ];
      };
    };

    userDirs =
    let
      homeDir = "/home/victor";
    in
    {
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
  };

  home.stateVersion = "24.05";
}
