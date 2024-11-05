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
      brightnessctl
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

    home.pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      gtk.enable = true;
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
    };

    xsession.windowManager.i3 = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "dmenu_run";

        window = {
          titlebar = false;
          border = 0;
        };

        keybindings = {
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";

          "${modifier}+d" = "exec --no-startup-id ${menu}";
          "${modifier}+Return" = "exec --no-startup-id ${terminal}";

          "${modifier}+Shift+e" = "exec --no-startup-id i3-msg exit";

          "${modifier}+Shift+q" = "kill";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+f" = "fullscreen";

          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+Shift+space" = "floating toggle";

          "${modifier}+minus" = "scratchpad show";
          "${modifier}+Shift+minus" = "move scratchpad";

          "${modifier}+a" = "focus parent";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+agrave" = "workspace number 1";
          "${modifier}+eacute" = "workspace number 2";
          "${modifier}+egrave" = "workspace number 3";
          "${modifier}+ecircumflex" = "workspace number 4";
          "${modifier}+parenleft" = "workspace number 5";
          "${modifier}+parenright" = "workspace number 6";
          "${modifier}+leftsinglequotemark" = "workspace number 7";
          "${modifier}+rightsinglequotemark" = "workspace number 8";
          "${modifier}+guillemotleft" = "workspace number 9";
          "${modifier}+guillemotright" = "workspace number 10";

          "${modifier}+Shift+agrave" = "move container to workspace number 1";
          "${modifier}+Shift+eacute" = "move container to workspace number 2";
          "${modifier}+Shift+egrave" = "move container to workspace number 3";
          "${modifier}+Shift+ecircumflex" = "move container to workspace number 4";
          "${modifier}+Shift+parenleft" = "move container to workspace number 5";
          "${modifier}+Shift+parenright" = "move container to workspace number 6";
          "${modifier}+Shift+leftsinglequotemark" = "move container to workspace number 7";
          "${modifier}+Shift+rightsinglequotemark" = "move container to workspace number 8";
          "${modifier}+Shift+guillemotleft" = "move container to workspace number 9";
          "${modifier}+Shift+guillemotright" = "move container to workspace number 10";
        };
      };
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
