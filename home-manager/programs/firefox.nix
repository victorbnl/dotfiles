{ nur, firefox-onebar, ... }:

{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        userChrome = (builtins.readFile firefox-onebar) + ''
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

        extensions = with nur.repos.rycee.firefox-addons; [
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
    };
  };
}
