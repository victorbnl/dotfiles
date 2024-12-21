{ pkgs, inputs, ... }:

{
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = 1;
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      icon = "spotify";
      genericName = "Music Player";
      exec = "firefox -p webapp open.spotify.com";
    };
  };

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        userChrome = (builtins.readFile inputs.firefox-onebar) + ''
          #navigator-toolbox {
            border-bottom: none !important;
          }

          #nav-bar {
            border-top: none !important;
          }
        '';

        bookmarks = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "YouTube";
                url = "https://www.youtube.com/";
              }
              {
                name = "Twitch";
                url = "https://www.twitch.tv/";
              }
            ];
          }
        ];

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          tabliss
          ublock-origin

          (buildFirefoxXpiAddon rec {
            pname = "kureteiyu-dark-theme";
            version = "1.0";
            addonId = "{f00ce5dc-ec40-41d1-abb5-8a974e97dae4}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4387100/kureteiyu_dark_theme-${version}.xpi";
            sha256 = "452087ffa7db1fe753770d074e94d0220fd9278aa626b1c69ff53f25a4a7ac7b";
            meta = {};
          })
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

          "browser.uiCustomization.state" = ''
            {
              "placements": {
                "nav-bar": [
                  "home-button",
                  "back-button",
                  "forward-button",
                  "stop-reload-button",
                  "urlbar-container",
                  "downloads-button",
                  "unified-extensions-button",
                  "ublock0_raymondhill_net-browser-action",
                  "addon_darkreader_org-browser-action",
                  "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                ],
                "toolbar-menubar": [
                  "menubar-items"
                ],
                "TabsToolbar": [
                  "tabbrowser-tabs",
                  "new-tab-button",
                  "alltabs-button"
                ],
                "PersonalToolbar": [
                  "personal-bookmarks"
                ]
              },
              "currentVersion": 20
            }
          '';
        };
      };

      webapp = {
        id = 1;
        name = "webapp";

        userChrome = ''
          #navigator-toolbox {
            visibility: collapse;
          }
        '';

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        settings = {
          "extensions.autoDisableScopes" = 0;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.eme.enabled" = true;
        };
      };
    };
  };
}
