{ pkgs, config, inputs, ... }:

{
  imports = [
    ./desktop
    ./programs

    ./packages.nix
  ];

  home = {
    packages = [
      (pkgs.writeShellScriptBin "init" ''
        cp --no-preserve=mode,ownership --recursive ${inputs.boilerplates}/$1/. .
      '')
    ];

    file.".xprofile".text = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';
  };

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
        homeDir = config.home.homeDirectory;
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
