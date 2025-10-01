{ lib, pkgs, names, config, inputs, ... }:

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
        dirs = ["desktop" "documents" "music" "pictures" "templates" "videos"];
        prefix = dir: "${config.home.homeDirectory}/${dir}";
        defs = lib.genAttrs dirs prefix;
      in
      {
        enable = true;
        publicShare = prefix "public";
        download = prefix "downloads";
      } // defs;
  };

  home.stateVersion = "24.05";
}
