{ config, inputs, lib, names, pkgs, ... }:

{
  imports = [
    ./desktop
    ./programs

    ./cloud.nix
    ./packages.nix
  ];

  home = {
    username = names.user;
    homeDirectory = "/home/${names.user}";

    packages = with pkgs;[
      pcmanfm
    ];

    # Session variables are set through the shell. This means that they are not
    # available to any other app by default. This loads them as X starts,
    # granted the display manager sources `~/.xprofile`.
    file.".xprofile".text = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';
  };

  xdg = {
    mimeApps = {
      enable = true;

      associations.added = builtins.mapAttrs (_: (map (value: "${value}.desktop"))) {
        "application/pdf" = [ "librewolf" ];
        "inode/directory" = [ "code" ];
      };

      defaultApplications = builtins.mapAttrs (_: value: ["${value}.desktop"]) {
        "application/pdf" = "librewolf";
        "application/zip" = "xarchiver";
        "inode/directory" = "pcmanfm";
        "image/jpeg" = "viewnior";
        "image/png" = "viewnior";
        "x-scheme-handler/http" = "librewolf";
        "x-scheme-handler/https" = "librewolf";
      };
    };

    userDirs =
      let
        dirs = ["documents" "music" "pictures" "templates" "videos"];
        prefix = dir: "${config.home.homeDirectory}/${dir}";
        defs = lib.genAttrs dirs prefix;
      in
      {
        enable = true;

        desktop = prefix ".desktop";
        download = prefix "downloads";
        publicShare = prefix "public";
      } // defs;
  };

  home.stateVersion = "24.05";
}
