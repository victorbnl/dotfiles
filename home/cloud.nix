{ config, secrets, ... }:
let
  mountPoint = "${config.home.homeDirectory}/.mnt/cloud";
in
{
  gtk.gtk3.bookmarks = [
    "file://${mountPoint}"
  ];

  programs.rclone = {
    enable = true;

    remotes = {
      mega.config = {
        inherit (secrets.cloud.mega) user pass;
        type = "mega";
      };

      drive.config = {
        inherit (secrets.cloud.drive) client_id client_secret token;
        type = "drive";
        scope = "drive.file";
      };

      union.config = {
        type = "union";
        upstreams = "mega: drive:";
      };

      crypt = {
        config = {
          inherit (secrets.cloud.crypt) password password2;
          type = "crypt";
          remote = "union:";
        };

        mounts."/" = {
          inherit mountPoint;
          enable = true;
          options.vfs-cache-mode = "off";
        };
      };
    };
  };
}
