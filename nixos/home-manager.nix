{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  firefox-userchrome = builtins.readFile (builtins.fetchurl "https://git.gay/freeplay/Firefox-Onebar/raw/branch/waf/onebar.css");
  homeDir = config.users.users.victor.home;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.backupFileExtension = "backup";

  home-manager.users.victor = {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
      ];

    home.packages = with pkgs; [
      alacritty
      dconf
    ];

    xresources.properties = {
      "Xft.dpi" = 134;
    };

    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=KvAdaptaDark
      '';

      "qt5ct/settings.ini".text = ''
        [Fonts]
        fixed="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
        general="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
      '';

      "qt6ct/settings.ini".text = ''
        [Fonts]
        fixed="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
        general="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      '';
    };

    gtk = {
      enable = true;

      theme = {
        name = "vimix-dark-doder";
        package = pkgs.vimix-gtk-themes;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "breeze_cursors";
        size = 20;
      };
    };

    xsession.windowManager.i3 = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
        };
      };
    };

    programs.git = {
      enable = true;

      userEmail = "victor.bonnelle@protonmail.com";
      userName = "Victor Bonnelle";
    };

    programs.firefox = {
      enable = true;

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          userChrome = firefox-userchrome;

          bookmarks = [
            {
              toolbar = true;
              bookmarks = [
                {
                  name = "YouTube";
                  url = "https://www.youtube.com";
                }
                {
                  name = "Discord";
                  url = "https://discord.com";
                }
              ];
            }
          ];

          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            tabliss
            ublock-origin
          ];

          settings = {
            "extensions.autoDisableScopes" = 0;

            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.inTitlebar" = 0;

            "browser.contentblocking.category" = "strict";
            "privacy.donottrackheader.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.globalprivacycontrol.enabled" = true;

            "browser.translations.automaticallyPopup" = false;
            "browser.aboutConfig.showWarning" = false;
          };
        };
      };
    };

    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        shardulm94.trailing-spaces
      ];
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
  };
}
