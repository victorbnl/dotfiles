{ pkgs, names, config, inputs, ... }:

{
  imports = [
    ./desktop
    ./programs

    ./packages.nix
  ];

  home = {
    username = names.user;
    homeDirectory = "/home/${names.user}";

    packages =
      with pkgs;
      let
        init-script = pkgs.writeShellScriptBin "init" ''
          cp --no-preserve=mode,ownership --recursive ${inputs.boilerplates}/$1/. .
        '';
      in [
        init-script
        pcmanfm
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
        "inode/directory" = [ "pcmanfm.desktop" ];
        "image/jpeg" = [ "viewnior.desktop" ];
        "image/png" = [ "viewnior.desktop" ];
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
