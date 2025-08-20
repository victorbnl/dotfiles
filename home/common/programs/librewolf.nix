{ pkgs, inputs, ... }:

{
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = 1;
  };

  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        userChrome = (builtins.readFile "${inputs.firefox-onebar}/onebar.css") + ''
          #navigator-toolbox {
            border-bottom: none !important;
          }

          #nav-bar {
            border-top: none !important;
          }
        '';

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          istilldontcareaboutcookies
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
          "privacy.resistFingerprinting" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

          "extensions.autoDisableScopes" = 0;

          "xpinstall.signatures.required" = false;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.inTitlebar" = 0;

          "browser.translations.automaticallyPopup" = false;
          "browser.aboutConfig.showWarning" = false;

          "extensions.activeThemeID" = "{f00ce5dc-ec40-41d1-abb5-8a974e97dae4}";

          "browser.toolbars.bookmarks.visibility" = "newtab";

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
