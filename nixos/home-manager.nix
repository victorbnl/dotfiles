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

    programs.waybar = {
      enable = true;

      settings = [{
        height = 25;
        modules-left = ["sway/workspaces"];
        modules-right = ["pulseaudio" "backlight" "battery" "clock"];
      }];
    };

    wayland.windowManager.sway = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "foot";
        menu = "dmenu_path | wmenu | xargs swaymsg exec --";

        input = {
          "type:keyboard" = {
            xkb_layout = "fr";
            xkb_variant = "afnor";
          };

          "type:touchpad" = {
            tap = "enabled";
          };
        };

        output."*".scale = "1.5";

        window = {
          titlebar = false;
          border = 0;
        };

        startup = [
          { command = "waybar"; }
          { command = "mako"; }
        ];

        keybindings = {
          "${modifier}+Shift+q" = "kill";

          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+e" = "exec swaymsg exit";

          "${modifier}+Shift+c" = "reload";

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

          "${modifier}+0xe0" = "workspace number 1";
          "${modifier}+0xe9" = "workspace number 2";
          "${modifier}+0xe8" = "workspace number 3";
          "${modifier}+0xea" = "workspace number 4";
          "${modifier}+0x28" = "workspace number 5";
          "${modifier}+0x29" = "workspace number 6";
          "${modifier}+0x2018" = "workspace number 7";
          "${modifier}+0x2019" = "workspace number 8";
          "${modifier}+0xab" = "workspace number 9";
          "${modifier}+0xbb" = "workspace number 10";

          "${modifier}+Shift+0xe0" = "move container to workspace number 1";
          "${modifier}+Shift+0xe9" = "move container to workspace number 2";
          "${modifier}+Shift+0xe8" = "move container to workspace number 3";
          "${modifier}+Shift+0xea" = "move container to workspace number 4";
          "${modifier}+Shift+0x28" = "move container to workspace number 5";
          "${modifier}+Shift+0x29" = "move container to workspace number 6";
          "${modifier}+Shift+0x2018" = "move container to workspace number 7";
          "${modifier}+Shift+0x2019" = "move container to workspace number 8";
          "${modifier}+Shift+0xab" = "move container to workspace number 9";
          "${modifier}+Shift+0xbb" = "move container to workspace number 10";
        };

        bars = [];
      };

      extraConfig = ''
        seat * xcursor_theme breeze_cursors 20
      '';
    };

    services.mako = {
      enable = true;
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
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.inTitlebar" = 0;

            "browser.contentblocking.category" = "strict";
            "privacy.donottrackheader.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.globalprivacycontrol.enabled" = true;

            "browser.translations.automaticallyPopup" = false;
          };
        };
      };
    };

    programs.vscode = {
      enable = true;
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
